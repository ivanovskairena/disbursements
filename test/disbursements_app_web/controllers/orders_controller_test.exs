defmodule DisbursementsAppWeb.OrdersControllerTest do
  use DisbursementsAppWeb.ConnCase

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Orders

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:orders) do
    {:ok, orders} = Disb.create_orders(@create_attrs)
    orders
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order", %{conn: conn} do
      conn = get(conn, Routes.orders_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create orders" do
    test "renders orders when data is valid", %{conn: conn} do
      conn = post(conn, Routes.orders_path(conn, :create), orders: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.orders_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.orders_path(conn, :create), orders: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update orders" do
    setup [:create_orders]

    test "renders orders when data is valid", %{conn: conn, orders: %Orders{id: id} = orders} do
      conn = put(conn, Routes.orders_path(conn, :update, orders), orders: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.orders_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, orders: orders} do
      conn = put(conn, Routes.orders_path(conn, :update, orders), orders: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete orders" do
    setup [:create_orders]

    test "deletes chosen orders", %{conn: conn, orders: orders} do
      conn = delete(conn, Routes.orders_path(conn, :delete, orders))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.orders_path(conn, :show, orders))
      end
    end
  end

  defp create_orders(_) do
    orders = fixture(:orders)
    %{orders: orders}
  end
end
