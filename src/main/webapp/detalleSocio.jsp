<%@page import="java.sql.*"%>
<%@ page import="java.util.Objects" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Detalle Socio</title>
</head>
<body>
<h1>Detalle de Socio</h1>

<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int socioID = -1;

    try {

        socioID = Integer.parseInt(request.getParameter("socioID"));

    } catch (Exception ex) {
        ex.printStackTrace();
        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet resultSocio = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection("jdbc:mysql://localhost:30306/baloncesto","root", "user");


            //>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
            //       Statement s = conexion.createStatement();
            //       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
            //                          + ", '" + request.getParameter("nombre")
            //                          + "', " + Integer.valueOf(request.getParameter("estatura"))
            //                          + ", " + Integer.valueOf(request.getParameter("edad"))
            //                          + ", '" + request.getParameter("localidad") + "')";
            //       s.execute(insercion);
            //<<<<<<

            //UTILIZAMOS PREPARE STATEMENT PARA QUERIES PARAMETRIZADAS.
            String sql = "SELECT * FROM socio WHERE socioID = ?"; //socioID
            ps = conexion.prepareStatement(sql);
            //int idx = 1;
            //ps.setInt(idx++, socioID); ESTO ME PERMITIRÍA AMPLIAR LA QUERY A FUTURO
            ps.setInt(1, socioID);
            resultSocio = ps.executeQuery();
            //ps.executeUpdate();

            if(resultSocio.next()){

                int numSocio = resultSocio.getInt("socioID");
                String nombre = resultSocio.getString("nombre");
                String localidad = resultSocio.getString("localidad");
    %>
            <table>
                <tr>
                    <td>SocioID: </td><td><%= numSocio%></td>
                </tr>
                <tr>
                    <td>Nombre: </td><td><%= nombre%></td>
                </tr>
                <tr>
                    <td>Localidad: </td><td><%= localidad%></td>
                </tr>
            </table>
    <%
            }

        }catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conexion.close();
            } catch (Exception e) { /* Ignored */ }
        }

    } else {
%>
    <span>Error de validación!</span>
<%
    }
%>
    <br>
    <a href="index.jsp">Página de inicio</a>

</body>
</html>