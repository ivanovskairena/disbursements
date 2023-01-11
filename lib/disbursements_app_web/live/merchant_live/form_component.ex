defmodule DisbursementsAppWeb.MerchantLive.FormComponent do
  use DisbursementsAppWeb, :live_component

  alias DisbursementsApp.Disb

  @impl true
  def update(%{merchant: merchant} = assigns, socket) do
    changeset = Disb.change_merchant(merchant)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"merchant" => merchant_params}, socket) do
    changeset =
      socket.assigns.merchant
      |> Disb.change_merchant(merchant_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"merchant" => merchant_params}, socket) do
    save_merchant(socket, socket.assigns.action, merchant_params)
  end

  defp save_merchant(socket, :edit, merchant_params) do
    case Disb.update_merchant(socket.assigns.merchant, merchant_params) do
      {:ok, _merchant} ->
        {:noreply,
         socket
         |> put_flash(:info, "Merchant updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_merchant(socket, :new, merchant_params) do
    case Disb.create_merchant(merchant_params) do
      {:ok, _merchant} ->
        {:noreply,
         socket
         |> put_flash(:info, "Merchant created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
