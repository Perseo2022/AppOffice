using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;


public partial class VuelosService : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string CancelarSolicitud(string codeEvento, string motivoCancelacion)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;
        SqlConnection sqlCon = null;
        using (sqlCon = new SqlConnection(connectionString))
        {
            sqlCon.Open();
            SqlCommand sql_cmnd = new SqlCommand("Appv_SPSetHistorico", sqlCon);
            sql_cmnd.CommandType = CommandType.StoredProcedure;
            sql_cmnd.Parameters.AddWithValue("@Cve_Solicitud", SqlDbType.NVarChar).Value = codeEvento;
            sql_cmnd.Parameters.AddWithValue("@Descripcion", SqlDbType.NVarChar).Value = motivoCancelacion;
            sql_cmnd.ExecuteNonQuery();
            sqlCon.Close();
        }
        return "OK";

    }

    [WebMethod]
    public static string getMoticoCancel(string codeEvento)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;
        string respuesta = "";

        using (SqlConnection cn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("dbo.AppV_SPGettHistorico"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@Cve_Solicitud", SqlDbType.VarChar);
                param.Value = codeEvento;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    cn.Close();
                    if (dt.Rows.Count > 0) { 
                    DataRow dsrow = dt.Rows[0];
                    respuesta = (string)dsrow["Descripcion"];
                }
                    return respuesta;
                }
            }
        }
        
    }   
    
    [WebMethod]
    public static string getPresupuesto(string ageClave)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;
        string respuesta = "";
        float total = 0;
        float restante = 0;

        using (SqlConnection cn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppV_SPGetPresupuesto"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@Age_clave", SqlDbType.Int);
                param.Value = ageClave;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    cn.Close();
                    if (dt.Rows.Count > 0) { 
                    DataRow dsrow = dt.Rows[0];
                    restante = (float)Convert.ToDouble(dsrow["Presupuesto_Restante"]);
                     total = (float)Convert.ToDouble(dsrow["Presupuesto_total"]);
                    }
                    if ((total* .25) > restante )
                    {
                        respuesta = "Se a ocupado mas del 75% del presupuesto";
                    }
                    return respuesta;
                }
            }
        }
        
    }
}