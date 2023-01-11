defmodule DisbursementsAppWeb.MerchantsControllerTest do
  use DisbursementsAppWeb.ConnCase

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Merchants

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:merchants) do
    {:ok, merchants} = Disb.create_merchants(@create_attrs)
    merchants
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all merchant", %{conn: conn} do
      conn = get(conn, Routes.merchants_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create merchants" do
    test "renders merchants when data is valid", %{conn: conn} do
      conn = post(conn, Routes.merchants_path(conn, :create), merchants: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.merchants_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.merchants_path(conn, :create), merchants: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update merchants" do
    setup [:create_merchants]

    test "renders merchants when data is valid", %{conn: conn, merchants: %Merchants{id: id} = merchants} do
      conn = put(conn, Routes.merchants_path(conn, :update, merchants), merchants: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.merchants_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, merchants: merchants} do
      conn = put(conn, Routes.merchants_path(conn, :update, merchants), merchants: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete merchants" do
    setup [:create_merchants]

    test "deletes chosen merchants", %{conn: conn, merchants: merchants} do
      conn = delete(conn, Routes.merchants_path(conn, :delete, merchants))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.merchants_path(conn, :show, merchants))
      end
    end
  end

  defp create_merchants(_) do
    merchants = fixture(:merchants)
    %{merchants: merchants}
  end
end
