
<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>CSE 3153 Group 5 Project</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            text-align: center;
            padding: 50px;
        }
        h1 { color: #243b55; }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            max-width: 600px;
            margin: auto;
        }
        .button {
            display: block;
            background-color: #2563eb;
            color: white;
            padding: 15px;
            margin: 15px;
            text-decoration: none;
            border-radius: 5px;
        }
        .button:hover {
            background-color: #1d4ed8;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <h1>CSE 3153 Group 5 Database Project</h1>
            <h2>Database Tables</h2>
            <p>Select a table to view its records.</p>

            <a class="button" href="Customers.aspx">
                View Customers
            </a>

            <a class="button" href="Products.aspx">
                View Products
            </a>

            <a class="button" href="Purchases.aspx">
                View Purchases
            </a>

        </div>
    </form>
</body>
</html>
