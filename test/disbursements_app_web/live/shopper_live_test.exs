defmodule DisbursementsAppWeb.ShopperLiveTest do
  use DisbursementsAppWeb.ConnCase

  import Phoenix.LiveViewTest

  alias DisbursementsApp.Disb

  @create_attrs %{email: "some email", name: "some name", nif: "some nif"}
  @update_attrs %{email: "some updated email", name: "some updated name", nif: "some updated nif"}
  @invalid_attrs %{email: nil, name: nil, nif: nil}

  defp fixture(:shopper) do
    {:ok, shopper} = Disb.create_shopper(@create_attrs)
    shopper
  end

  defp create_shopper(_) do
    shopper = fixture(:shopper)
    %{shopper: shopper}
  end

  describe "Index" do
    setup [:create_shopper]

    test "lists all shoppers", %{conn: conn, shopper: shopper} do
      {:ok, _index_live, html} = live(conn, Routes.shopper_index_path(conn, :index))

      assert html =~ "Listing Shoppers"
      assert html =~ shopper.email
    end

    test "saves new shopper", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.shopper_index_path(conn, :index))

      assert index_live |> element("a", "New Shopper") |> render_click() =~
               "New Shopper"

      assert_patch(index_live, Routes.shopper_index_path(conn, :new))

      assert index_live
             |> form("#shopper-form", shopper: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#shopper-form", shopper: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shopper_index_path(conn, :index))

      assert html =~ "Shopper created successfully"
      assert html =~ "some email"
    end

    test "updates shopper in listing", %{conn: conn, shopper: shopper} do
      {:ok, index_live, _html} = live(conn, Routes.shopper_index_path(conn, :index))

      assert index_live |> element("#shopper-#{shopper.id} a", "Edit") |> render_click() =~
               "Edit Shopper"

      assert_patch(index_live, Routes.shopper_index_path(conn, :edit, shopper))

      assert index_live
             |> form("#shopper-form", shopper: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#shopper-form", shopper: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shopper_index_path(conn, :index))

      assert html =~ "Shopper updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes shopper in listing", %{conn: conn, shopper: shopper} do
      {:ok, index_live, _html} = live(conn, Routes.shopper_index_path(conn, :index))

      assert index_live |> element("#shopper-#{shopper.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#shopper-#{shopper.id}")
    end
  end

  describe "Show" do
    setup [:create_shopper]

    test "displays shopper", %{conn: conn, shopper: shopper} do
      {:ok, _show_live, html} = live(conn, Routes.shopper_show_path(conn, :show, shopper))

      assert html =~ "Show Shopper"
      assert html =~ shopper.email
    end

    test "updates shopper within modal", %{conn: conn, shopper: shopper} do
      {:ok, show_live, _html} = live(conn, Routes.shopper_show_path(conn, :show, shopper))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Shopper"

      assert_patch(show_live, Routes.shopper_show_path(conn, :edit, shopper))

      assert show_live
             |> form("#shopper-form", shopper: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#shopper-form", shopper: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shopper_show_path(conn, :show, shopper))

      assert html =~ "Shopper updated successfully"
      assert html =~ "some updated email"
    end
  end
end
