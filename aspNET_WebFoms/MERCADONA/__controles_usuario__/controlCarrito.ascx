<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="controlCarrito.ascx.cs" Inherits="MerCadona.__Controles_Usuario__.controlCarrito" %>
<style type="text/css">
    .auto-style1 {
        width: 77px;
    }
</style>
<div style="width:200px; background-color: #FFCC00; text-align:center; border: thin solid #FF9933;">
    <label for="Descripcion" style="font-family: 'Arial Black'; font-size: small;">Descripion</label>
    <label for="Descripcion" style="font-family: 'Arial Black'; font-size: small;">Cant.</label>
    <label for="Descripcion" style="font-family: 'Arial Black'; font-size: small;">EUROS</label>
</div>
<div style="width:200px;">
    <asp:Table ID="TablaMiniProductos" runat="server" BackColor="#FFCC66" BorderStyle="Ridge"></asp:Table>
</div>
<div style="width:200px; background-color: #FFCC66; border: thin solid #FF9933; text-align:right;">
    <label for="Descripcion" style="font-family: 'Arial Black'; font-size: small;">Coste Prep. y envio: </label>
    <label for="Descripcion" style="font-family: 'Arial'; font-size: small;">7,21</label><br />
    <label for="Descripcion" style="font-family: 'Arial Black'; font-size: small;">IVA 10%: </label> <asp:Label ID="LblIVA" runat="server" Text="0"></asp:Label>
</div>
<div style="width:200px; background-color: #FFCC66; border: thin solid #FF9933; text-align:right;">
    <label for="Descripcion" style="font-family: 'Arial Black'; font-size: small;">TOTAL: </label> <asp:Label ID="LblTotal" runat="server" Text="0"></asp:Label>
</div>
<div style="width:200px; background-color: #FFCC00; border: thin solid #FF9933; text-align:center;">
    <table>
        <tr>
            <td class="auto-style1">
                <asp:ImageButton ID="BtnGuardarPedido" runat="server" ImageUrl="~/imagenes/imagenes_CompraOnline/botonCarritoGuardar.png" />
            </td>
            <td style="width:40px;"></td>
            <td>
                <asp:ImageButton ID="BtnFormalizarPedido" runat="server" ImageUrl="~/imagenes/imagenes_CompraOnline/botonCarritoFormalizar.png" Width="70px" Height="57px" />
            </td>
        </tr>
    </table>
</div>