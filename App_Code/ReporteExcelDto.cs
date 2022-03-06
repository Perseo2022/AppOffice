using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de ReporteExcelDto
/// </summary>
public class ReporteExcelDto
{
    public ReporteExcelDto()
    {
        
    }
    public string FechaSolicitud { get; set; }
    public string Nombre { get; set; }
    public string Apellidos { get; set; }
    public string vuelo { get; set; }
    public string Periodo { get; set; }
    public string Horario { get; set; }
    public string Destino { get; set; }
    public string Aerolinea { get; set; }
    public string Reservacion { get; set; }
    public float Total { get; set; }
    public string Area { get; set; }
    public string Agencia { get; set; }
    public string Clve { get; set; }
}