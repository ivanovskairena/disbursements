defmodule DisbursementsAppWeb.ShopperLive.FormComponent do
  use DisbursementsAppWeb, :live_component

  alias DisbursementsApp.Disb

  @impl true
  def update(%{shopper: shopper} = assigns, socket) do
    changeset = Disb.change_shopper(shopper)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"shopper" => shopper_params}, socket) do
    changeset =
      socket.assigns.shopper
      |> Disb.change_shopper(shopper_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"shopper" => shopper_params}, socket) do
    save_shopper(socket, socket.assigns.action, shopper_params)
  end

  defp save_shopper(socket, :edit, shopper_params) do
    case Disb.update_shopper(socket.assigns.shopper, shopper_params) do
      {:ok, _shopper} ->
        {:noreply,
         socket
         |> put_flash(:info, "Shopper updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_shopper(socket, :new, shopper_params) do
    case Disb.create_shopper(shopper_params) do
      {:ok, _shopper} ->
        {:noreply,
         socket
         |> put_flash(:info, "Shopper created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
