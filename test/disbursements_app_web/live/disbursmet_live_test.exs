defmodule DisbursementsAppWeb.DisbursmetLiveTest do
  use DisbursementsAppWeb.ConnCase

  import Phoenix.LiveViewTest

  alias DisbursementsApp.Disb

  @create_attrs %{amount: 120.5, week: 42, year: 42}
  @update_attrs %{amount: 456.7, week: 43, year: 43}
  @invalid_attrs %{amount: nil, week: nil, year: nil}

  defp fixture(:disbursmet) do
    {:ok, disbursmet} = Disb.create_disbursmet(@create_attrs)
    disbursmet
  end

  defp create_disbursmet(_) do
    disbursmet = fixture(:disbursmet)
    %{disbursmet: disbursmet}
  end

  describe "Index" do
    setup [:create_disbursmet]

    test "lists all disbursements", %{conn: conn, disbursmet: disbursmet} do
      {:ok, _index_live, html} = live(conn, Routes.disbursmet_index_path(conn, :index))

      assert html =~ "Listing Disbursements"
    end

    test "saves new disbursmet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.disbursmet_index_path(conn, :index))

      assert index_live |> element("a", "New Disbursmet") |> render_click() =~
               "New Disbursmet"

      assert_patch(index_live, Routes.disbursmet_index_path(conn, :new))

      assert index_live
             |> form("#disbursmet-form", disbursmet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#disbursmet-form", disbursmet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disbursmet_index_path(conn, :index))

      assert html =~ "Disbursmet created successfully"
    end

    test "updates disbursmet in listing", %{conn: conn, disbursmet: disbursmet} do
      {:ok, index_live, _html} = live(conn, Routes.disbursmet_index_path(conn, :index))

      assert index_live |> element("#disbursmet-#{disbursmet.id} a", "Edit") |> render_click() =~
               "Edit Disbursmet"

      assert_patch(index_live, Routes.disbursmet_index_path(conn, :edit, disbursmet))

      assert index_live
             |> form("#disbursmet-form", disbursmet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#disbursmet-form", disbursmet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disbursmet_index_path(conn, :index))

      assert html =~ "Disbursmet updated successfully"
    end

    test "deletes disbursmet in listing", %{conn: conn, disbursmet: disbursmet} do
      {:ok, index_live, _html} = live(conn, Routes.disbursmet_index_path(conn, :index))

      assert index_live |> element("#disbursmet-#{disbursmet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#disbursmet-#{disbursmet.id}")
    end
  end

  describe "Show" do
    setup [:create_disbursmet]

    test "displays disbursmet", %{conn: conn, disbursmet: disbursmet} do
      {:ok, _show_live, html} = live(conn, Routes.disbursmet_show_path(conn, :show, disbursmet))

      assert html =~ "Show Disbursmet"
    end

    test "updates disbursmet within modal", %{conn: conn, disbursmet: disbursmet} do
      {:ok, show_live, _html} = live(conn, Routes.disbursmet_show_path(conn, :show, disbursmet))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Disbursmet"

      assert_patch(show_live, Routes.disbursmet_show_path(conn, :edit, disbursmet))

      assert show_live
             |> form("#disbursmet-form", disbursmet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#disbursmet-form", disbursmet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disbursmet_show_path(conn, :show, disbursmet))

      assert html =~ "Disbursmet updated successfully"
    end
  end
end
