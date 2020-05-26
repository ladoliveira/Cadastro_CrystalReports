<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProjetoCadastroRelatorioCrystal._Default" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%@ PreviousPageType VirtualPath ="~/Teste.aspx" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Crystal Reports</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="Scripts/WebForms/jquery.js"></script>
    <script src="Scripts/WebForms/jquery_mask.js"></script>
    <link href="Scripts/Sweet/sweetalert2.min.css" rel="stylesheet" />
    <script src="Scripts/Sweet/sweetalert2.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body>
    <script type="text/javascript">
        $(document).ready(() => {

            $("#txtDataInicial").mask("99/99/9999");
            $("#txtDataFinal").mask("99/99/9999");


            $("#validarCampos").on("click", () => {
                var dataInicial = $("#txtDataInicial").val();
                var dataFinal = $("#txtDataFinal").val();

                if (dataInicial.length != 10 || dataInicial == "") {
                    $('#txtDataInicial').trigger("focus");
                    Swal.fire({ icon: 'error', title: 'Oops...', text: 'Por favor informe a data inicial.', footer: '' });
                    document.getElementById("txtDataInicial").value = "";
                    return false;
                }

                if (dataFinal.length != 10 || dataFinal == "") {
                    $('#txtDataFinal').trigger("focus");
                    Swal.fire({ icon: 'error', title: 'Oops...', text: 'Por favor informe a data final.', footer: '' });
                    document.getElementById("txtDataFinal").value = "";
                    return false;
                }

                if (dataInicial > dataFinal) {
                    $('#txtDataInicial').trigger("focus");
                    Swal.fire({ icon: 'error', title: 'Oops...', text: 'Data inicial deve ser menor que data final.', footer: '' });
                    document.getElementById("txtDataInicial").value = "";
                    return false;
                }
                $("#btnGerarRelatorio").click();
                event.preventDefault();
            });
        });

        function ExibirRelatorioModal() {
            $('#botaoFantasma').click();
        }
    </script>

    <div class="container">
        <h2>Cadastro de Clientes</h2>
        <form id="frmCrystalReports" runat="server">
            <asp:Button ID="gerarRelatorio" class="btn btn-primary" runat="server" Text="Gerar Relatório" OnClick="gerarRelatorio_Click" />
            <asp:Button ID="btnExportarExcel" class="btn btn-danger" runat="server" Text="Exportar Excel" OnClick="btnExportarExcel_Click" />
            <button type="button" id="btnModal1" class="btn btn-info" data-toggle="modal" data-target="#modalFiltrarPeriodo">Relatório por Período</button>
            <br />
            <br />
            <div id="modalFiltrarPeriodo" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Gerar Relatório por Período</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-md-1 control-label" style="padding-left: 0px" for="txtDataInicial">
                                    INÍCIO
                                </label>
                                <div class="col-md-3">
                                    <input type="text" id="txtDataInicial" class="form-control input-md" runat="server" />
                                </div>
                                <label class="col-md-1 control-label" for="txtDataFinal">
                                    FIM
                                </label>
                                <div class="col-md-3">
                                    <input type="text" id="txtDataFinal" class="form-control input-md" runat="server" />
                                </div>
                            </div>
                            <br />
                        </div>
                        <br />
                        <div style="text-align: center">
                            <asp:Button ID="btnGerarRelatorio" class="btn btn-info btn-lg" Style="display: none" runat="server" Text="gerar relatório" OnClick="btnGerarRelatorio_Click" />
                            <asp:Button ID="validarCampos" class="btn btn-info btn-lg" runat="server" Text="Gerar Relatório" ToolTip="Gerar Relatório" />
                        </div>
                        <br />
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <button type="button" style="display: none;" id="botaoFantasma" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#modalExibirRelatorio">Abrir Relatório</button>
            </div>
            <div class="modal fade" id="modalExibirRelatorio" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Relatório por Período</h4>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">

                                <CR:CrystalReportViewer CssClass="table" ID="CrystalReportViewer2" runat="server" AutoDataBind="True" ReportSourceID="CrystalReportSourceClientes" ToolPanelView="None" DisplayToolbar="False" HasToggleGroupTreeButton="false" />
                                <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                                    <Report FileName="RelatorioCliente.rpt">
                                    </Report>
                                </CR:CrystalReportSource>

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>
            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True" ReportSourceID="CrystalReportSourceClientes" ToolPanelView="None" />
            <CR:CrystalReportSource ID="CrystalReportSourceClientes" runat="server">
                <Report FileName="RelatorioCliente.rpt">
                </Report>
            </CR:CrystalReportSource>
        </form>
    </div>
</body>
</html>
