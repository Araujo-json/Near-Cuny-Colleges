
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    //getting data from the index file
    String latIn = request.getParameter("latitude");
    String lonIn = request.getParameter("longitude");
    String distanceIn = request.getParameter("distance");

    try {
        //connection to the database
        String db = "jdbc:mysql://localhost:3306/cuny_addresses", password = "",
                user = "root", dbTable = "cuny_addresses_table";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(db, user, password);
        //the calculation in use is called Haversine Formula, 3959 is use to calculate distance in miles(for kilometers use 6371)
        String sqlSelect =
                " SELECT *,  (3959 * acos(sin(radians(" + latIn + ")) * sin(radians(Latitude)) + cos(radians(" + latIn + "))"
                        + "*cos(radians(Latitude)) * cos(radians(Longitude) - radians(" + lonIn + ")))) AS distance "
                        + " FROM " + dbTable
                        + " HAVING distance < " + distanceIn;
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sqlSelect);
        //initialize variables
        String collegeType, college, website, address, city, state, zip,
                phone, location = "";
        Double lat, lon;

        if(rs != null)
        {
            while (rs.next()) {
                //college type is not necessary
//                collegeType = rs.getString("College Type");
                college = rs.getString("College");//college name
                website  = rs.getString("Website");//webpage
                address = rs.getString("Address");//address
                city = rs.getString("City");//city
                state = rs.getString("State");//state
                zip = rs.getString("Zip");//zipcode
                lat = rs.getDouble("Latitude");//lat
                lon = rs.getDouble("Longitude");//lon
                phone = rs.getString("Phone");//office number
                //colleges info
                location += college + "," + website + "," + address + "," + city + ","
                        + state + "," + zip + "," + lat + "," + lon + "," + phone + ";";
            }
            //passes the data on a hidden input (can be seen if user inspect)
            out.println("<input value='" + location + "' id='collegeList' type='hidden' />");
        }
        else
            out.println("No college found");
    }
    catch (SQLException e){}
%>
