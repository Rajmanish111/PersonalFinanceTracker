<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
            background: #0a0e27;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Animated Background */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            background: linear-gradient(45deg, #0a0e27, #1a1f3a, #0f1428);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
        }

        @keyframes gradientShift {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        /* Grid Overlay */
        .grid-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                linear-gradient(rgba(99, 102, 241, 0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(99, 102, 241, 0.03) 1px, transparent 1px);
            background-size: 50px 50px;
            z-index: 1;
            pointer-events: none;
        }

        /* Glowing Orbs */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.3;
            pointer-events: none;
            z-index: 0;
        }

        .orb-1 {
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, #6366f1, transparent);
            top: -200px;
            right: -200px;
            animation: orbFloat 20s ease-in-out infinite;
        }

        .orb-2 {
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, #a855f7, transparent);
            bottom: -250px;
            left: -250px;
            animation: orbFloat 20s ease-in-out infinite;
            animation-delay: -10s;
        }

        @keyframes orbFloat {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(50px, -50px) scale(1.1); }
            66% { transform: translate(-50px, 50px) scale(0.9); }
        }

        /* Scanline Effect */
        .scanline {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(transparent, rgba(99, 102, 241, 0.5), transparent);
            animation: scanline 8s linear infinite;
            pointer-events: none;
            z-index: 10;
        }

        @keyframes scanline {
            0% { transform: translateY(-100%); }
            100% { transform: translateY(100vh); }
        }

        /* Main Container */
        .container {
            position: relative;
            z-index: 10;
            min-height: 100vh;
            padding: 40px;
            max-width: 1600px;
            margin: 0 auto;
        }

        /* Header */
        .page-header {
            margin-bottom: 40px;
            animation: fadeInDown 0.8s ease-out;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .page-title {
            font-size: 42px;
            font-weight: 800;
            background: linear-gradient(135deg, #6366f1, #a855f7, #ec4899);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: gradientFlow 3s ease infinite;
            letter-spacing: -2px;
            margin-bottom: 10px;
        }

        @keyframes gradientFlow {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .page-subtitle {
            color: rgba(255, 255, 255, 0.6);
            font-size: 16px;
        }

        /* Filter Section */
        .filter-section {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            animation: fadeInUp 0.8s ease-out 0.2s both;
            position: relative;
            overflow: hidden;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .filter-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, #6366f1, #a855f7, #ec4899);
            background-size: 200% 100%;
            animation: gradientSlide 3s ease infinite;
        }

        @keyframes gradientSlide {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .filter-title {
            font-size: 18px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .filter-label {
            font-size: 13px;
            color: rgba(255, 255, 255, 0.7);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        select, input[type="date"] {
            padding: 12px 16px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 10px;
            color: #fff;
            font-size: 14px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            cursor: pointer;
        }

        select:focus, input[type="date"]:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.08);
            border-color: #6366f1;
            box-shadow: 0 0 20px rgba(99, 102, 241, 0.3);
        }

        select option {
            background: #1a1f3a;
            color: #fff;
        }

        .filter-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        button, .reset-link {
            padding: 12px 28px;
            background: linear-gradient(135deg, #6366f1, #a855f7);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(99, 102, 241, 0.3);
            display: inline-block;
        }

        button::before, .reset-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        button:hover::before, .reset-link:hover::before {
            left: 100%;
        }

        button:hover, .reset-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(99, 102, 241, 0.5);
        }

        .reset-link {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.3);
        }

        /* Table Section */
        .table-section {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 20px;
            padding: 0;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out 0.4s both;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: rgba(99, 102, 241, 0.1);
            border-bottom: 2px solid rgba(99, 102, 241, 0.3);
        }

        th {
            padding: 18px 20px;
            text-align: left;
            font-size: 13px;
            font-weight: 700;
            color: rgba(255, 255, 255, 0.9);
            text-transform: uppercase;
            letter-spacing: 1px;
            border: none;
        }

        td {
            padding: 16px 20px;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
            border: none;
            border-bottom: 1px solid rgba(99, 102, 241, 0.1);
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: rgba(99, 102, 241, 0.05);
            transform: scale(1.01);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        /* Transaction Type Badges */
        .type-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .type-credited {
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
            box-shadow: 0 0 15px rgba(16, 185, 129, 0.2);
        }

        .type-debited {
            background: rgba(239, 68, 68, 0.15);
            color: #ff6b6b;
            border: 1px solid rgba(239, 68, 68, 0.3);
            box-shadow: 0 0 15px rgba(239, 68, 68, 0.2);
        }

        /* Amount Styling */
        .amount-credited {
            color: #10b981;
            font-weight: 700;
            text-shadow: 0 0 10px rgba(16, 185, 129, 0.3);
        }

        .amount-debited {
            color: #ff6b6b;
            font-weight: 700;
            text-shadow: 0 0 10px rgba(239, 68, 68, 0.3);
        }

        /* Action Links */
        .action-link {
            color: #a855f7;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }

        .action-link::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: #a855f7;
            transition: width 0.3s ease;
        }

        .action-link:hover {
            color: #ec4899;
        }

        .action-link:hover::after {
            width: 100%;
        }

        .action-link.delete {
            color: #ff6b6b;
        }

        .action-link.delete:hover {
            color: #ef4444;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-message {
            color: rgba(255, 255, 255, 0.6);
            font-size: 18px;
            font-weight: 600;
        }

        /* Back Button */
        .back-section {
            margin-top: 30px;
            animation: fadeInUp 0.8s ease-out 0.6s both;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.3);
            border-radius: 10px;
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: #6366f1;
            transform: translateX(-5px);
            box-shadow: 0 5px 20px rgba(99, 102, 241, 0.3);
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .container {
                padding: 30px 20px;
            }

            .filter-grid {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 32px;
            }

            .filter-grid {
                grid-template-columns: 1fr;
            }

            .table-section {
                overflow-x: auto;
            }

            table {
                min-width: 800px;
            }

            .filter-actions {
                flex-direction: column;
            }

            button, .reset-link {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- Background Elements -->
<div class="bg-animation"></div>
<div class="grid-overlay"></div>
<div class="scanline"></div>

<!-- Glowing Orbs -->
<div class="orb orb-1"></div>
<div class="orb orb-2"></div>

<div class="container">
    
    <!-- Header -->
    <div class="page-header">
        <h1 class="page-title">📜 Transaction History</h1>
        <p class="page-subtitle">View and manage all your financial transactions</p>
    </div>

    <!-- Filter Section -->
    <div class="filter-section">
        <h3 class="filter-title">🔍 Filter & Sort</h3>
        
        <form action="${pageContext.request.contextPath}/transactions/history" method="get">
            <div class="filter-grid">
                <!-- Type Filter -->
                <div class="filter-group">
                    <label class="filter-label">Type</label>
                    <select name="type">
                        <option value="">All</option>
                        <option value="CREDITED" <c:if test="${selectedType=='CREDITED'}">selected</c:if>>CREDITED</option>
                        <option value="DEBITED" <c:if test="${selectedType=='DEBITED'}">selected</c:if>>DEBITED</option>
                    </select>
                </div>

                <!-- Category Filter -->
                <div class="filter-group">
                    <label class="filter-label">Category</label>
                    <select name="category">
                        <option value="">All</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}" <c:if test="${selectedCategory==cat}">selected</c:if>>${cat}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Start Date Filter -->
                <div class="filter-group">
                    <label class="filter-label">Start Date</label>
                    <input type="date" name="startDate" value="${startDate}" />
                </div>

                <!-- End Date Filter -->
                <div class="filter-group">
                    <label class="filter-label">End Date</label>
                    <input type="date" name="endDate" value="${endDate}" />
                </div>

                <!-- Sort Field -->
                <div class="filter-group">
                    <label class="filter-label">Sort By</label>
                    <select name="sortField">
                        <option value="transactionDateTime" <c:if test="${sortField=='transactionDateTime'}">selected</c:if>>Date</option>
                        <option value="amount" <c:if test="${sortField=='amount'}">selected</c:if>>Amount</option>
                    </select>
                </div>

                <!-- Sort Direction -->
                <div class="filter-group">
                    <label class="filter-label">Order</label>
                    <select name="sortDir">
                        <option value="asc" <c:if test="${sortDir=='asc'}">selected</c:if>>Ascending</option>
                        <option value="desc" <c:if test="${sortDir=='desc'}">selected</c:if>>Descending</option>
                    </select>
                </div>
            </div>

            <div class="filter-actions">
                <button type="submit">Apply Filters</button>
                <a href="${pageContext.request.contextPath}/transactions/history" class="reset-link">Reset All</a>
            </div>
        </form>
    </div>

    <!-- Table Section -->
    <c:choose>
        <c:when test="${not empty transactions}">
            <div class="table-section">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Amount</th>
                            <th>Type</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Date/Time</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="txn" items="${transactions}">
                            <tr>
                                <td>${txn.id}</td>
                                <td class="${txn.type == 'CREDITED' ? 'amount-credited' : 'amount-debited'}">
                                    ₹ ${txn.amount}
                                </td>
                                <td>
                                    <span class="type-badge ${txn.type == 'CREDITED' ? 'type-credited' : 'type-debited'}">
                                        ${txn.type}
                                    </span>
                                </td>
                                <td>${txn.category}</td>
                                <td>${txn.description}</td>
                                <td>${txn.transactionDateTime}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/transactions/edit/${txn.id}" class="action-link">Edit</a>
                                    |
                                    <a href="${pageContext.request.contextPath}/transactions/delete/${txn.id}" 
                                       class="action-link delete"
                                       onclick="return confirm('Are you sure you want to delete this transaction?');">
                                       Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-section">
                <div class="empty-state">
                    <div class="empty-icon">📭</div>
                    <p class="empty-message">No transactions found.</p>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Back Button -->
    <div class="back-section">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="back-btn">
            ← Back to Dashboard
        </a>
    </div>

</div>

<script>
    // Create floating particles
    function createParticles() {
        const particleCount = 40;
        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';
            particle.style.cssText = `
                position: fixed;
                width: 3px;
                height: 3px;
                background: rgba(99, 102, 241, 0.5);
                border-radius: 50%;
                pointer-events: none;
                z-index: 1;
                left: ${Math.random() * 100}%;
                top: ${Math.random() * 100}%;
            `;
            
            const style = document.createElement('style');
            const animName = 'particleFloat' + i;
            style.innerHTML = `
                @keyframes ${animName} {
                    0%, 100% { 
                        transform: translate(0, 0); 
                        opacity: 0;
                    }
                    10% { opacity: 1; }
                    90% { opacity: 1; }
                    100% { 
                        transform: translate(${Math.random() * 200 - 100}px, ${Math.random() * 200 - 100}px);
                        opacity: 0;
                    }
                }
            `;
            document.head.appendChild(style);
            particle.style.animation = `${animName} ${Math.random() * 4 + 3}s ease-in-out infinite`;
            
            document.body.appendChild(particle);
        }
    }

    window.addEventListener('load', createParticles);
</script>

</body>
</html>
