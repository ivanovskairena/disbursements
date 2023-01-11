defmodule DisbursementsAppWeb.ShoppersControllerTest do
  use DisbursementsAppWeb.ConnCase

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Shoppers

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:shoppers) do
    {:ok, shoppers} = Disb.create_shoppers(@create_attrs)
    shoppers
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all shopper", %{conn: conn} do
      conn = get(conn, Routes.shoppers_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create shoppers" do
    test "renders shoppers when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shoppers_path(conn, :create), shoppers: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.shoppers_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shoppers_path(conn, :create), shoppers: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update shoppers" do
    setup [:create_shoppers]

    test "renders shoppers when data is valid", %{conn: conn, shoppers: %Shoppers{id: id} = shoppers} do
      conn = put(conn, Routes.shoppers_path(conn, :update, shoppers), shoppers: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.shoppers_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, shoppers: shoppers} do
      conn = put(conn, Routes.shoppers_path(conn, :update, shoppers), shoppers: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete shoppers" do
    setup [:create_shoppers]

    test "deletes chosen shoppers", %{conn: conn, shoppers: shoppers} do
      conn = delete(conn, Routes.shoppers_path(conn, :delete, shoppers))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.shoppers_path(conn, :show, shoppers))
      end
    end
  end

  defp create_shoppers(_) do
    shoppers = fixture(:shoppers)
    %{shoppers: shoppers}
  end
end
