defmodule DisbursementsApp.DisbTest do
  use DisbursementsApp.DataCase

  alias DisbursementsApp.Disb

  describe "merchants" do
    alias DisbursementsApp.Disb.Merchant

    @valid_attrs %{cif: "some cif", email: "some email", name: "some name"}
    @update_attrs %{cif: "some updated cif", email: "some updated email", name: "some updated name"}
    @invalid_attrs %{cif: nil, email: nil, name: nil}

    def merchant_fixture(attrs \\ %{}) do
      {:ok, merchant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Disb.create_merchant()

      merchant
    end

    test "list_merchants/0 returns all merchants" do
      merchant = merchant_fixture()
      assert Disb.list_merchants() == [merchant]
    end

    test "get_merchant!/1 returns the merchant with given id" do
      merchant = merchant_fixture()
      assert Disb.get_merchant!(merchant.id) == merchant
    end

    test "create_merchant/1 with valid data creates a merchant" do
      assert {:ok, %Merchant{} = merchant} = Disb.create_merchant(@valid_attrs)
      assert merchant.cif == "some cif"
      assert merchant.email == "some email"
      assert merchant.name == "some name"
    end

    test "create_merchant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disb.create_merchant(@invalid_attrs)
    end

    test "update_merchant/2 with valid data updates the merchant" do
      merchant = merchant_fixture()
      assert {:ok, %Merchant{} = merchant} = Disb.update_merchant(merchant, @update_attrs)
      assert merchant.cif == "some updated cif"
      assert merchant.email == "some updated email"
      assert merchant.name == "some updated name"
    end

    test "update_merchant/2 with invalid data returns error changeset" do
      merchant = merchant_fixture()
      assert {:error, %Ecto.Changeset{}} = Disb.update_merchant(merchant, @invalid_attrs)
      assert merchant == Disb.get_merchant!(merchant.id)
    end

    test "delete_merchant/1 deletes the merchant" do
      merchant = merchant_fixture()
      assert {:ok, %Merchant{}} = Disb.delete_merchant(merchant)
      assert_raise Ecto.NoResultsError, fn -> Disb.get_merchant!(merchant.id) end
    end

    test "change_merchant/1 returns a merchant changeset" do
      merchant = merchant_fixture()
      assert %Ecto.Changeset{} = Disb.change_merchant(merchant)
    end
  end

  describe "orders" do
    alias DisbursementsApp.Disb.Order

    @valid_attrs %{amount: 120.5, completed_at: "2010-04-17T14:00:00Z", created_at: "2010-04-17T14:00:00Z"}
    @update_attrs %{amount: 456.7, completed_at: "2011-05-18T15:01:01Z", created_at: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{amount: nil, completed_at: nil, created_at: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Disb.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Disb.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Disb.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Disb.create_order(@valid_attrs)
      assert order.amount == 120.5
      assert order.completed_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert order.created_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disb.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Disb.update_order(order, @update_attrs)
      assert order.amount == 456.7
      assert order.completed_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert order.created_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Disb.update_order(order, @invalid_attrs)
      assert order == Disb.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Disb.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Disb.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Disb.change_order(order)
    end
  end

  describe "merchant" do
    alias DisbursementsApp.Disb.Merchants

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def merchants_fixture(attrs \\ %{}) do
      {:ok, merchants} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Disb.create_merchants()

      merchants
    end

    test "list_merchant/0 returns all merchant" do
      merchants = merchants_fixture()
      assert Disb.list_merchant() == [merchants]
    end

    test "get_merchants!/1 returns the merchants with given id" do
      merchants = merchants_fixture()
      assert Disb.get_merchants!(merchants.id) == merchants
    end

    test "create_merchants/1 with valid data creates a merchants" do
      assert {:ok, %Merchants{} = merchants} = Disb.create_merchants(@valid_attrs)
    end

    test "create_merchants/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disb.create_merchants(@invalid_attrs)
    end

    test "update_merchants/2 with valid data updates the merchants" do
      merchants = merchants_fixture()
      assert {:ok, %Merchants{} = merchants} = Disb.update_merchants(merchants, @update_attrs)
    end

    test "update_merchants/2 with invalid data returns error changeset" do
      merchants = merchants_fixture()
      assert {:error, %Ecto.Changeset{}} = Disb.update_merchants(merchants, @invalid_attrs)
      assert merchants == Disb.get_merchants!(merchants.id)
    end

    test "delete_merchants/1 deletes the merchants" do
      merchants = merchants_fixture()
      assert {:ok, %Merchants{}} = Disb.delete_merchants(merchants)
      assert_raise Ecto.NoResultsError, fn -> Disb.get_merchants!(merchants.id) end
    end

    test "change_merchants/1 returns a merchants changeset" do
      merchants = merchants_fixture()
      assert %Ecto.Changeset{} = Disb.change_merchants(merchants)
    end
  end

  describe "shopper" do
    alias DisbursementsApp.Disb.Shoppers

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def shoppers_fixture(attrs \\ %{}) do
      {:ok, shoppers} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Disb.create_shoppers()

      shoppers
    end

    test "list_shopper/0 returns all shopper" do
      shoppers = shoppers_fixture()
      assert Disb.list_shopper() == [shoppers]
    end

    test "get_shoppers!/1 returns the shoppers with given id" do
      shoppers = shoppers_fixture()
      assert Disb.get_shoppers!(shoppers.id) == shoppers
    end

    test "create_shoppers/1 with valid data creates a shoppers" do
      assert {:ok, %Shoppers{} = shoppers} = Disb.create_shoppers(@valid_attrs)
    end

    test "create_shoppers/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disb.create_shoppers(@invalid_attrs)
    end

    test "update_shoppers/2 with valid data updates the shoppers" do
      shoppers = shoppers_fixture()
      assert {:ok, %Shoppers{} = shoppers} = Disb.update_shoppers(shoppers, @update_attrs)
    end

    test "update_shoppers/2 with invalid data returns error changeset" do
      shoppers = shoppers_fixture()
      assert {:error, %Ecto.Changeset{}} = Disb.update_shoppers(shoppers, @invalid_attrs)
      assert shoppers == Disb.get_shoppers!(shoppers.id)
    end

    test "delete_shoppers/1 deletes the shoppers" do
      shoppers = shoppers_fixture()
      assert {:ok, %Shoppers{}} = Disb.delete_shoppers(shoppers)
      assert_raise Ecto.NoResultsError, fn -> Disb.get_shoppers!(shoppers.id) end
    end

    test "change_shoppers/1 returns a shoppers changeset" do
      shoppers = shoppers_fixture()
      assert %Ecto.Changeset{} = Disb.change_shoppers(shoppers)
    end
  end

  describe "order" do
    alias DisbursementsApp.Disb.Orders

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def orders_fixture(attrs \\ %{}) do
      {:ok, orders} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Disb.create_orders()

      orders
    end

    test "list_order/0 returns all order" do
      orders = orders_fixture()
      assert Disb.list_order() == [orders]
    end

    test "get_orders!/1 returns the orders with given id" do
      orders = orders_fixture()
      assert Disb.get_orders!(orders.id) == orders
    end

    test "create_orders/1 with valid data creates a orders" do
      assert {:ok, %Orders{} = orders} = Disb.create_orders(@valid_attrs)
    end

    test "create_orders/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disb.create_orders(@invalid_attrs)
    end

    test "update_orders/2 with valid data updates the orders" do
      orders = orders_fixture()
      assert {:ok, %Orders{} = orders} = Disb.update_orders(orders, @update_attrs)
    end

    test "update_orders/2 with invalid data returns error changeset" do
      orders = orders_fixture()
      assert {:error, %Ecto.Changeset{}} = Disb.update_orders(orders, @invalid_attrs)
      assert orders == Disb.get_orders!(orders.id)
    end

    test "delete_orders/1 deletes the orders" do
      orders = orders_fixture()
      assert {:ok, %Orders{}} = Disb.delete_orders(orders)
      assert_raise Ecto.NoResultsError, fn -> Disb.get_orders!(orders.id) end
    end

    test "change_orders/1 returns a orders changeset" do
      orders = orders_fixture()
      assert %Ecto.Changeset{} = Disb.change_orders(orders)
    end
  end

  describe "orders" do
    alias DisbursementsApp.Disb.Order

    @valid_attrs %{amount: 120.5, completed_at: ~N[2010-04-17 14:00:00], created_at: ~N[2010-04-17 14:00:00], mechant_id: "some mechant_id", shopper_id: "some shopper_id"}
    @update_attrs %{amount: 456.7, completed_at: ~N[2011-05-18 15:01:01], created_at: ~N[2011-05-18 15:01:01], mechant_id: "some updated mechant_id", shopper_id: "some updated shopper_id"}
    @invalid_attrs %{amount: nil, completed_at: nil, created_at: nil, mechant_id: nil, shopper_id: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Disb.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Disb.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Disb.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Disb.create_order(@valid_attrs)
      assert order.amount == 120.5
      assert order.completed_at == ~N[2010-04-17 14:00:00]
      assert order.created_at == ~N[2010-04-17 14:00:00]
      assert order.mechant_id == "some mechant_id"
      assert order.shopper_id == "some shopper_id"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disb.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Disb.update_order(order, @update_attrs)
      assert order.amount == 456.7
      assert order.completed_at == ~N[2011-05-18 15:01:01]
      assert order.created_at == ~N[2011-05-18 15:01:01]
      assert order.mechant_id == "some updated mechant_id"
      assert order.shopper_id == "some updated shopper_id"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Disb.update_order(order, @invalid_attrs)
      assert order == Disb.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Disb.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Disb.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Disb.change_order(order)
    end
  end

  describe "disbursements" do
    alias DisbursementsApp.Disb.Disbursmet

    @valid_attrs %{amount: 120.5, week: 42, year: 42}
    @update_attrs %{amount: 456.7, week: 43, year: 43}
    @invalid_attrs %{amount: nil, week: nil, year: nil}

    def disbursmet_fixture(attrs \\ %{}) do
      {:ok, disbursmet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Disb.create_disbursmet()

      disbursmet
    end

    test "list_disbursements/0 returns all disbursements" do
      disbursmet = disbursmet_fixture()
      assert Disb.list_disbursements() == [disbursmet]
    end

    test "get_disbursmet!/1 returns the disbursmet with given id" do
      disbursmet = disbursmet_fixture()
      assert Disb.get_disbursmet!(disbursmet.id) == disbursmet
    end

    test "create_disbursmet/1 with valid data creates a disbursmet" do
      assert {:ok, %Disbursmet{} = disbursmet} = Disb.create_disbursmet(@valid_attrs)
      assert disbursmet.amount == 120.5
      assert disbursmet.week == 42
      assert disbursmet.year == 42
    end

    test "create_disbursmet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disb.create_disbursmet(@invalid_attrs)
    end

    test "update_disbursmet/2 with valid data updates the disbursmet" do
      disbursmet = disbursmet_fixture()
      assert {:ok, %Disbursmet{} = disbursmet} = Disb.update_disbursmet(disbursmet, @update_attrs)
      assert disbursmet.amount == 456.7
      assert disbursmet.week == 43
      assert disbursmet.year == 43
    end

    test "update_disbursmet/2 with invalid data returns error changeset" do
      disbursmet = disbursmet_fixture()
      assert {:error, %Ecto.Changeset{}} = Disb.update_disbursmet(disbursmet, @invalid_attrs)
      assert disbursmet == Disb.get_disbursmet!(disbursmet.id)
    end

    test "delete_disbursmet/1 deletes the disbursmet" do
      disbursmet = disbursmet_fixture()
      assert {:ok, %Disbursmet{}} = Disb.delete_disbursmet(disbursmet)
      assert_raise Ecto.NoResultsError, fn -> Disb.get_disbursmet!(disbursmet.id) end
    end

    test "change_disbursmet/1 returns a disbursmet changeset" do
      disbursmet = disbursmet_fixture()
      assert %Ecto.Changeset{} = Disb.change_disbursmet(disbursmet)
    end
  end

  describe "disbursements" do
    alias DisbursementsApp.Disb.Disbursement

    @valid_attrs %{amount: 120.5, week: 42, year: 42}
    @update_attrs %{amount: 456.7, week: 43, year: 43}
    @invalid_attrs %{amount: nil, week: nil, year: nil}

    def disbursement_fixture(attrs \\ %{}) do
      {:ok, disbursement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Disb.create_disbursement()

      disbursement
    end

    test "list_disbursements/0 returns all disbursements" do
      disbursement = disbursement_fixture()
      assert Disb.list_disbursements() == [disbursement]
    end

    test "get_disbursement!/1 returns the disbursement with given id" do
      disbursement = disbursement_fixture()
      assert Disb.get_disbursement!(disbursement.id) == disbursement
    end

    test "create_disbursement/1 with valid data creates a disbursement" do
      assert {:ok, %Disbursement{} = disbursement} = Disb.create_disbursement(@valid_attrs)
      assert disbursement.amount == 120.5
      assert disbursement.week == 42
      assert disbursement.year == 42
    end

    test "create_disbursement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disb.create_disbursement(@invalid_attrs)
    end

    test "update_disbursement/2 with valid data updates the disbursement" do
      disbursement = disbursement_fixture()
      assert {:ok, %Disbursement{} = disbursement} = Disb.update_disbursement(disbursement, @update_attrs)
      assert disbursement.amount == 456.7
      assert disbursement.week == 43
      assert disbursement.year == 43
    end

    test "update_disbursement/2 with invalid data returns error changeset" do
      disbursement = disbursement_fixture()
      assert {:error, %Ecto.Changeset{}} = Disb.update_disbursement(disbursement, @invalid_attrs)
      assert disbursement == Disb.get_disbursement!(disbursement.id)
    end

    test "delete_disbursement/1 deletes the disbursement" do
      disbursement = disbursement_fixture()
      assert {:ok, %Disbursement{}} = Disb.delete_disbursement(disbursement)
      assert_raise Ecto.NoResultsError, fn -> Disb.get_disbursement!(disbursement.id) end
    end

    test "change_disbursement/1 returns a disbursement changeset" do
      disbursement = disbursement_fixture()
      assert %Ecto.Changeset{} = Disb.change_disbursement(disbursement)
    end
  end
end
