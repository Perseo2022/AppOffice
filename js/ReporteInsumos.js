var ReporteInsumos = {
    initOnReady: function () {
        $('#GV_Solicitud').on('click', 'tr td', function (evt) {
            var codigo = $(this).parents("tr").find("td").eq(1).text();
           // ReporteInsumos.descarga(codigo);
            fileName = "ReporteInsumos" + codigo+".xlsx";
            $.ajax({
                type: "POST",
                url: "ExcelSevice.aspx/DescargaReporteInsumo",
                data: '{clave: "' + codigo + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    //Convert Base64 string to Byte Array.
                    var bytes = ReporteInsumos.Base64ToBytes(r.d);

                    //Convert Byte Array to BLOB.
                    var blob = new Blob([bytes], { type: "application/octetstream" });

                    //Check the Browser type and download the File.
                    var isIE = false || !!document.documentMode;
                    if (isIE) {
                        window.navigator.msSaveBlob(blob, fileName);
                    } else {
                        var url = window.URL || window.webkitURL;
                        link = url.createObjectURL(blob);
                        var a = $("<a />");
                        a.attr("download", fileName);
                        a.attr("href", link);
                        $("body").append(a);
                        a[0].click();
                        $("body").remove(a);
                    }
                }
            });

        });

    },

Base64ToBytes: function(base64) {
    var s = window.atob(base64);
    var bytes = new Uint8Array(s.length);
    for (var i = 0; i < s.length; i++) {
        bytes[i] = s.charCodeAt(i);
    }
    return bytes;
}

}
$(document).ready(function () {
    ReporteInsumos.initOnReady();

});
