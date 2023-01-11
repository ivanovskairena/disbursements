defmodule DisbursementsAppWeb.MerchantLiveTest do
  use DisbursementsAppWeb.ConnCase

  import Phoenix.LiveViewTest

  alias DisbursementsApp.Disb

  @create_attrs %{cif: "some cif", email: "some email", name: "some name"}
  @update_attrs %{cif: "some updated cif", email: "some updated email", name: "some updated name"}
  @invalid_attrs %{cif: nil, email: nil, name: nil}

  defp fixture(:merchant) do
    {:ok, merchant} = Disb.create_merchant(@create_attrs)
    merchant
  end

  defp create_merchant(_) do
    merchant = fixture(:merchant)
    %{merchant: merchant}
  end

  describe "Index" do
    setup [:create_merchant]

    test "lists all merchants", %{conn: conn, merchant: merchant} do
      {:ok, _index_live, html} = live(conn, Routes.merchant_index_path(conn, :index))

      assert html =~ "Listing Merchants"
      assert html =~ merchant.cif
    end

    test "saves new merchant", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.merchant_index_path(conn, :index))

      assert index_live |> element("a", "New Merchant") |> render_click() =~
               "New Merchant"

      assert_patch(index_live, Routes.merchant_index_path(conn, :new))

      assert index_live
             |> form("#merchant-form", merchant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#merchant-form", merchant: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.merchant_index_path(conn, :index))

      assert html =~ "Merchant created successfully"
      assert html =~ "some cif"
    end

    test "updates merchant in listing", %{conn: conn, merchant: merchant} do
      {:ok, index_live, _html} = live(conn, Routes.merchant_index_path(conn, :index))

      assert index_live |> element("#merchant-#{merchant.id} a", "Edit") |> render_click() =~
               "Edit Merchant"

      assert_patch(index_live, Routes.merchant_index_path(conn, :edit, merchant))

      assert index_live
             |> form("#merchant-form", merchant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#merchant-form", merchant: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.merchant_index_path(conn, :index))

      assert html =~ "Merchant updated successfully"
      assert html =~ "some updated cif"
    end

    test "deletes merchant in listing", %{conn: conn, merchant: merchant} do
      {:ok, index_live, _html} = live(conn, Routes.merchant_index_path(conn, :index))

      assert index_live |> element("#merchant-#{merchant.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#merchant-#{merchant.id}")
    end
  end

  describe "Show" do
    setup [:create_merchant]

    test "displays merchant", %{conn: conn, merchant: merchant} do
      {:ok, _show_live, html} = live(conn, Routes.merchant_show_path(conn, :show, merchant))

      assert html =~ "Show Merchant"
      assert html =~ merchant.cif
    end

    test "updates merchant within modal", %{conn: conn, merchant: merchant} do
      {:ok, show_live, _html} = live(conn, Routes.merchant_show_path(conn, :show, merchant))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Merchant"

      assert_patch(show_live, Routes.merchant_show_path(conn, :edit, merchant))

      assert show_live
             |> form("#merchant-form", merchant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#merchant-form", merchant: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.merchant_show_path(conn, :show, merchant))

      assert html =~ "Merchant updated successfully"
      assert html =~ "some updated cif"
    end
  end
end
