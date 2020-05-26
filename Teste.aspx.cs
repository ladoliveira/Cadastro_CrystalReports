using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjetoCadastroRelatorioCrystal
{
    public partial class Teste : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var dt = Session["dataT"];
                RelatorioCliente rpt = new RelatorioCliente();
                rpt.SetDataSource(dt);
                CrystalReportViewer3.ReportSource = rpt;
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "");
            }

        }
    }
}