defmodule DisbursementsAppWeb.DisbursementLiveTest do
  use DisbursementsAppWeb.ConnCase

  import Phoenix.LiveViewTest

  alias DisbursementsApp.Disb

  @create_attrs %{amount: 120.5, week: 42, year: 42}
  @update_attrs %{amount: 456.7, week: 43, year: 43}
  @invalid_attrs %{amount: nil, week: nil, year: nil}

  defp fixture(:disbursement) do
    {:ok, disbursement} = Disb.create_disbursement(@create_attrs)
    disbursement
  end

  defp create_disbursement(_) do
    disbursement = fixture(:disbursement)
    %{disbursement: disbursement}
  end

  describe "Index" do
    setup [:create_disbursement]

    test "lists all disbursements", %{conn: conn, disbursement: disbursement} do
      {:ok, _index_live, html} = live(conn, Routes.disbursement_index_path(conn, :index))

      assert html =~ "Listing Disbursements"
    end

    test "saves new disbursement", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.disbursement_index_path(conn, :index))

      assert index_live |> element("a", "New Disbursement") |> render_click() =~
               "New Disbursement"

      assert_patch(index_live, Routes.disbursement_index_path(conn, :new))

      assert index_live
             |> form("#disbursement-form", disbursement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#disbursement-form", disbursement: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disbursement_index_path(conn, :index))

      assert html =~ "Disbursement created successfully"
    end

    test "updates disbursement in listing", %{conn: conn, disbursement: disbursement} do
      {:ok, index_live, _html} = live(conn, Routes.disbursement_index_path(conn, :index))

      assert index_live |> element("#disbursement-#{disbursement.id} a", "Edit") |> render_click() =~
               "Edit Disbursement"

      assert_patch(index_live, Routes.disbursement_index_path(conn, :edit, disbursement))

      assert index_live
             |> form("#disbursement-form", disbursement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#disbursement-form", disbursement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disbursement_index_path(conn, :index))

      assert html =~ "Disbursement updated successfully"
    end

    test "deletes disbursement in listing", %{conn: conn, disbursement: disbursement} do
      {:ok, index_live, _html} = live(conn, Routes.disbursement_index_path(conn, :index))

      assert index_live |> element("#disbursement-#{disbursement.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#disbursement-#{disbursement.id}")
    end
  end

  describe "Show" do
    setup [:create_disbursement]

    test "displays disbursement", %{conn: conn, disbursement: disbursement} do
      {:ok, _show_live, html} = live(conn, Routes.disbursement_show_path(conn, :show, disbursement))

      assert html =~ "Show Disbursement"
    end

    test "updates disbursement within modal", %{conn: conn, disbursement: disbursement} do
      {:ok, show_live, _html} = live(conn, Routes.disbursement_show_path(conn, :show, disbursement))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Disbursement"

      assert_patch(show_live, Routes.disbursement_show_path(conn, :edit, disbursement))

      assert show_live
             |> form("#disbursement-form", disbursement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#disbursement-form", disbursement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disbursement_show_path(conn, :show, disbursement))

      assert html =~ "Disbursement updated successfully"
    end
  end
end
