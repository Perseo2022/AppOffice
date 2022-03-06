using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de InsumoEvento
/// </summary>
public class InsumoEvento
{
    public InsumoEvento()
    {
    }

    public int Codigo { get; set; }
    public string Descripcion { get; set; }
    public string UnidadMedida { get; set; }
    public int Cantidad { get; set; }
}