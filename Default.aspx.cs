using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using ProjetoCadastroRelatorioCrystal.dsClienteTableAdapters;

namespace ProjetoCadastroRelatorioCrystal
{
    public partial class _Default : Page
    {
        RelatorioCliente rpt = new RelatorioCliente();

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void gerarRelatorio_Click(object sender, EventArgs e)
        {
            dsClienteTableAdapters.ClienteTableAdapter da = new dsClienteTableAdapters.ClienteTableAdapter();
            dsCliente ds = new dsCliente();
            dsCliente.ClienteDataTable dt = (dsCliente.ClienteDataTable)
            ds.Tables["Cliente"];
            da.Fill(dt);
            rpt.SetDataSource(ds);
            CrystalReportViewer1.ReportSource = rpt;
            rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "Teste");
        }

        protected void btnExportarExcel_Click(object sender, EventArgs e)
        {
            dsClienteTableAdapters.ClienteTableAdapter da = new dsClienteTableAdapters.ClienteTableAdapter();
            dsCliente ds = new dsCliente();
            dsCliente.ClienteDataTable dt = (dsCliente.ClienteDataTable)
            ds.Tables["Cliente"];
            da.Fill(dt);
            rpt.SetDataSource(ds);
            CrystalReportViewer1.ReportSource = rpt;
            rpt.ExportToHttpResponse(ExportFormatType.Excel, Response, false, "Teste");
        }

        protected void btnGerarRelatorio_Click(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conexao"].ConnectionString;
            SqlConnection con = new SqlConnection(conString);

            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM CLIENTE WHERE convert(date,DataInclusao,103) BETWEEN convert(date,@dataInicial,103) AND convert(date,@dataFinal,103) ORDER BY CodigoCliente ASC", con);
            
            cmd.Parameters.AddWithValue("@dataInicial", txtDataInicial.Value);
            cmd.Parameters.AddWithValue("@dataFinal", txtDataFinal.Value);

            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();

            dt.Load(dr);

            if (dt.Rows.Count == 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "radomtext;", "Swal.fire({icon: 'error', title: 'Oops...', text: 'Nenhum registro encontrado!', footer: ''});", true);
                con.Close();
            }
            else
            {
                con.Close();
                Session["dataT"] = dt;
                Response.Write("<script>");
                Response.Write("window.open('Teste.aspx')");
                Response.Write("</script>");
            }
        }
    }
}