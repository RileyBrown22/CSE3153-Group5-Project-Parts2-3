
<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Products - Group 5 Project</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            padding: 40px;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            max-width: 1100px;
            margin: auto;
        }
        h1 { color: #243b55; }
        .grid {
            width: 100%;
            border-collapse: collapse;
        }
        .grid th {
            background-color: #2563eb;
            color: white;
            padding: 12px;
        }
        .grid td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .back {
            display: inline-block;
            margin-bottom: 20px;
            color: #2563eb;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <a class="back" href="Default.aspx">
                Back to Home
            </a>

            <h1>Product Records</h1>
            <p>Products stored in the database.</p>

            <asp:GridView
                ID="GridView1"
                runat="server"
                AutoGenerateColumns="True"
                CssClass="grid"
                DataSourceID="SqlDataSource1"
                EmptyDataText="No product records found.">
            </asp:GridView>

            <asp:SqlDataSource
                ID="SqlDataSource1"
                runat="server"
                ConnectionString="<%$ ConnectionStrings:ProjectDB %>"
                ProviderName="<%$ ConnectionStrings:ProjectDB.ProviderName %>"
                SelectCommand="SELECT * FROM dbo.Product">
            </asp:SqlDataSource>

        </div>
    </form>
</body>
</html>
