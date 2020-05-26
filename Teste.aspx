<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teste.aspx.cs" Inherits="ProjetoCadastroRelatorioCrystal.Teste" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/WebForms/jquery.js"></script>
    <script src="Scripts/jquery-3.4.1.min.js"></script>
</head>
<body>
    
    <form id="form1" runat="server">

        
        <div>
            <CR:CrystalReportViewer CssClass="table" ID="CrystalReportViewer3" runat="server" AutoDataBind="True" ReportSourceID="CrystalReportSourceClientes" ToolPanelView="None" />
            <CR:CrystalReportSource ID="CrystalReportSourceClientes" runat="server">
                <Report FileName="RelatorioCliente.rpt" />
            </CR:CrystalReportSource>
        </div>
    </form>
</body>
</html>
