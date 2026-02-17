<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Dashboard</title>

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

    /* Floating Particles */
    .particle {
        position: fixed;
        width: 3px;
        height: 3px;
        background: rgba(99, 102, 241, 0.5);
        border-radius: 50%;
        pointer-events: none;
        z-index: 1;
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

    .orb-3 {
        width: 350px;
        height: 350px;
        background: radial-gradient(circle, #ec4899, transparent);
        top: 40%;
        right: 10%;
        animation: orbFloat 20s ease-in-out infinite;
        animation-delay: -5s;
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

    /* Main Layout */
    .dashboard-wrapper {
        position: relative;
        z-index: 10;
        min-height: 100vh;
    }

    /* Top Navigation Bar */
    .navbar {
        background: rgba(255, 255, 255, 0.03);
        backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(99, 102, 241, 0.2);
        padding: 20px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3);
        animation: slideDown 0.8s ease-out;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .navbar-brand {
        font-size: 24px;
        font-weight: 800;
        background: linear-gradient(135deg, #6366f1, #a855f7, #ec4899);
        background-size: 200% 200%;
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        animation: gradientFlow 3s ease infinite;
        letter-spacing: -1px;
    }

    @keyframes gradientFlow {
        0%, 100% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
    }

    .navbar-user {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .user-info {
        color: rgba(255, 255, 255, 0.8);
        font-size: 16px;
        font-weight: 600;
    }

    .user-info span {
        color: #a855f7;
        text-shadow: 0 0 10px rgba(168, 85, 247, 0.5);
    }

    .logout-btn {
        padding: 10px 24px;
        background: rgba(239, 68, 68, 0.1);
        color: #ff6b6b;
        border: 1px solid rgba(239, 68, 68, 0.3);
        border-radius: 10px;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .logout-btn:hover {
        background: rgba(239, 68, 68, 0.2);
        border-color: #ff6b6b;
        transform: translateY(-2px);
        box-shadow: 0 5px 20px rgba(239, 68, 68, 0.3);
    }

    /* Main Content Area */
    .dashboard-content {
        padding: 40px;
        max-width: 1400px;
        margin: 0 auto;
    }

    /* Welcome Section */
    .welcome-section {
        margin-bottom: 40px;
        animation: fadeInUp 0.8s ease-out 0.2s both;
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

    .welcome-title {
        font-size: 36px;
        font-weight: 800;
        color: #fff;
        margin-bottom: 10px;
    }

    .welcome-subtitle {
        font-size: 18px;
        color: rgba(255, 255, 255, 0.6);
    }

    /* Stats Grid */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
        margin-bottom: 40px;
    }

    .stat-card {
        background: rgba(255, 255, 255, 0.03);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(99, 102, 241, 0.2);
        border-radius: 20px;
        padding: 30px;
        position: relative;
        overflow: hidden;
        transition: all 0.3s ease;
        animation: fadeInUp 0.8s ease-out both;
        cursor: pointer;
    }

    .stat-card:nth-child(1) { animation-delay: 0.3s; }
    .stat-card:nth-child(2) { animation-delay: 0.4s; }
    .stat-card:nth-child(3) { animation-delay: 0.5s; }

    .stat-card::before {
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

    .stat-card:hover {
        transform: translateY(-5px);
        border-color: rgba(99, 102, 241, 0.5);
        box-shadow: 0 10px 40px rgba(99, 102, 241, 0.3);
    }

    .stat-icon {
        font-size: 48px;
        margin-bottom: 15px;
        display: inline-block;
        animation: float 3s ease-in-out infinite;
    }

    @keyframes float {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
    }

    .stat-label {
        font-size: 14px;
        color: rgba(255, 255, 255, 0.6);
        text-transform: uppercase;
        letter-spacing: 1px;
        font-weight: 600;
        margin-bottom: 10px;
    }

    .stat-value {
        font-size: 32px;
        font-weight: 800;
        color: #fff;
        text-shadow: 0 0 20px rgba(255, 255, 255, 0.3);
    }

    .stat-value.balance {
        color: #10b981;
        text-shadow: 0 0 20px rgba(16, 185, 129, 0.5);
    }

    .stat-value.budget {
        color: #6366f1;
        text-shadow: 0 0 20px rgba(99, 102, 241, 0.5);
    }

    .stat-value.spent {
        color: #ec4899;
        text-shadow: 0 0 20px rgba(236, 72, 153, 0.5);
    }

    /* Quick Actions */
    .quick-actions {
        margin-bottom: 40px;
        animation: fadeInUp 0.8s ease-out 0.6s both;
    }

    .section-title {
        font-size: 24px;
        font-weight: 700;
        color: #fff;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .section-title::before {
        content: '';
        width: 4px;
        height: 24px;
        background: linear-gradient(180deg, #6366f1, #a855f7);
        border-radius: 2px;
    }

    .actions-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
    }

    .action-card {
        background: rgba(255, 255, 255, 0.03);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(99, 102, 241, 0.2);
        border-radius: 16px;
        padding: 25px;
        text-align: center;
        text-decoration: none;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .action-card::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, transparent, #6366f1, transparent);
        transform: translateX(-100%);
        transition: transform 0.6s ease;
    }

    .action-card:hover::after {
        transform: translateX(100%);
    }

    .action-card:hover {
        transform: translateY(-5px);
        border-color: rgba(99, 102, 241, 0.5);
        box-shadow: 0 10px 40px rgba(99, 102, 241, 0.3);
    }

    .action-icon {
        font-size: 40px;
        margin-bottom: 12px;
    }

    .action-title {
        font-size: 18px;
        font-weight: 700;
        color: #fff;
        margin-bottom: 8px;
    }

    .action-desc {
        font-size: 13px;
        color: rgba(255, 255, 255, 0.5);
    }

    /* Budget Section */
    .budget-section {
        animation: fadeInUp 0.8s ease-out 0.7s both;
    }

    .budget-card {
        background: rgba(255, 255, 255, 0.03);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(99, 102, 241, 0.2);
        border-radius: 20px;
        padding: 35px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
    }

    .budget-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: linear-gradient(90deg, #6366f1, #a855f7, #ec4899);
        background-size: 200% 100%;
        animation: gradientSlide 3s ease infinite;
    }

    .budget-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }

    .budget-title {
        font-size: 22px;
        font-weight: 700;
        color: #fff;
    }

    .budget-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 25px;
        margin-bottom: 25px;
    }

    .budget-item {
        background: rgba(99, 102, 241, 0.05);
        border: 1px solid rgba(99, 102, 241, 0.2);
        border-radius: 12px;
        padding: 20px;
        transition: all 0.3s ease;
    }

    .budget-item:hover {
        background: rgba(99, 102, 241, 0.1);
        transform: translateY(-3px);
    }

    .budget-item-label {
        font-size: 13px;
        color: rgba(255, 255, 255, 0.6);
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 8px;
        font-weight: 600;
    }

    .budget-item-value {
        font-size: 24px;
        font-weight: 800;
        color: #fff;
    }

    .budget-warning {
        padding: 18px;
        background: rgba(239, 68, 68, 0.1);
        border: 1px solid rgba(239, 68, 68, 0.3);
        border-radius: 12px;
        color: #ff6b6b;
        font-weight: 700;
        text-align: center;
        animation: pulse 2s ease-in-out infinite;
        box-shadow: 0 0 20px rgba(239, 68, 68, 0.2);
        margin-bottom: 20px;
    }

    @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.7; }
    }

    .budget-not-set {
        padding: 40px;
        text-align: center;
        background: rgba(251, 191, 36, 0.05);
        border: 1px solid rgba(251, 191, 36, 0.2);
        border-radius: 12px;
        margin-bottom: 20px;
    }

    .budget-not-set-icon {
        font-size: 48px;
        margin-bottom: 15px;
    }

    .budget-not-set-text {
        color: #fbbf24;
        font-weight: 700;
        font-size: 18px;
        margin-bottom: 8px;
    }

    .budget-not-set-desc {
        color: rgba(255, 255, 255, 0.5);
        font-size: 14px;
    }

    .budget-action-btn {
        display: inline-block;
        padding: 14px 32px;
        background: linear-gradient(135deg, #6366f1, #a855f7);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 15px;
        font-weight: 700;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 1px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
    }

    .budget-action-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s ease;
    }

    .budget-action-btn:hover::before {
        left: 100%;
    }

    .budget-action-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 35px rgba(99, 102, 241, 0.5);
    }

    /* Responsive */
    @media (max-width: 1024px) {
        .dashboard-content {
            padding: 30px 20px;
        }

        .stats-grid {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 768px) {
        .navbar {
            padding: 15px 20px;
            flex-direction: column;
            gap: 15px;
        }

        .navbar-brand {
            font-size: 20px;
        }

        .navbar-user {
            flex-direction: column;
            gap: 10px;
        }

        .welcome-title {
            font-size: 28px;
        }

        .actions-grid {
            grid-template-columns: 1fr;
        }

        .budget-details {
            grid-template-columns: 1fr;
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
<div class="orb orb-3"></div>

<div class="dashboard-wrapper">
    <!-- Top Navigation -->
    <nav class="navbar">
        <div class="navbar-brand">💰 Finance Tracker</div>
        <div class="navbar-user">
            <div class="user-info">
                Hello, <span><c:out value="${sessionScope.loggedInUser.name}" /></span> 👋
            </div>
            <a class="logout-btn" href="${pageContext.request.contextPath}/users/logout">Logout</a>
        </div>
    </nav>

    <!-- Main Dashboard Content -->
    <div class="dashboard-content">
        
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h1 class="welcome-title">Dashboard Overview</h1>
            <p class="welcome-subtitle">Monitor your financial health at a glance</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <!-- Balance Card -->
            <div class="stat-card">
                <div class="stat-icon">💳</div>
                <div class="stat-label">Current Balance</div>
                <div class="stat-value balance">₹ <c:out value="${balance}" /></div>
            </div>

            <!-- Budget Card (if set) -->
            <c:if test="${budgetSet}">
                <div class="stat-card">
                    <div class="stat-icon">🎯</div>
                    <div class="stat-label">Monthly Budget</div>
                    <div class="stat-value budget">₹ <c:out value="${budgetAmount}" /></div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">💸</div>
                    <div class="stat-label">Total Spent</div>
                    <div class="stat-value spent">₹ <c:out value="${spentAmount}" /></div>
                </div>
            </c:if>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <h2 class="section-title">Quick Actions</h2>
            <div class="actions-grid">
                <a href="${pageContext.request.contextPath}/transactions/add" class="action-card">
                    <div class="action-icon">➕</div>
                    <div class="action-title">Add Transaction</div>
                    <div class="action-desc">Record a new expense or income</div>
                </a>

                <a href="${pageContext.request.contextPath}/transactions/history" class="action-card">
                    <div class="action-icon">📜</div>
                    <div class="action-title">Transaction History</div>
                    <div class="action-desc">View all your transactions</div>
                </a>

                <c:choose>
                    <c:when test="${budgetSet}">
                        <a href="${pageContext.request.contextPath}/budget/set?month=${budgetMonth}&year=${budgetYear}" class="action-card">
                            <div class="action-icon">⚙️</div>
                            <div class="action-title">Update Budget</div>
                            <div class="action-desc">Modify your monthly budget</div>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/budget/set?month=${budgetMonth}&year=${budgetYear}" class="action-card">
                            <div class="action-icon">🎯</div>
                            <div class="action-title">Set Budget</div>
                            <div class="action-desc">Create your first budget</div>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Budget Section -->
        <div class="budget-section">
            <h2 class="section-title">Monthly Budget Overview</h2>
            <div class="budget-card">
                <c:choose>
                    <c:when test="${budgetSet}">
                        <div class="budget-header">
                            <div class="budget-title">Current Month Budget Status</div>
                        </div>

                        <c:if test="${budgetExceeded}">
                            <div class="budget-warning">
                                ⚠️ Budget Exceeded! You have spent more than your monthly budget.
                            </div>
                        </c:if>

                        <div class="budget-details">
                            <div class="budget-item">
                                <div class="budget-item-label">Budget Amount</div>
                                <div class="budget-item-value">₹ <c:out value="${budgetAmount}" /></div>
                            </div>

                            <div class="budget-item">
                                <div class="budget-item-label">Total Spent</div>
                                <div class="budget-item-value">₹ <c:out value="${spentAmount}" /></div>
                            </div>

                            <div class="budget-item">
                                <div class="budget-item-label">Remaining</div>
                                <div class="budget-item-value">₹ <c:out value="${remainingAmount}" /></div>
                            </div>
                        </div>

                        <a class="budget-action-btn"
                           href="${pageContext.request.contextPath}/budget/set?month=${budgetMonth}&year=${budgetYear}">
                            Update Budget
                        </a>
                    </c:when>

                    <c:otherwise>
                        <div class="budget-not-set">
                            <div class="budget-not-set-icon">📊</div>
                            <div class="budget-not-set-text">No Budget Set</div>
                            <div class="budget-not-set-desc">Set a monthly budget to track your spending</div>
                        </div>

                        <a class="budget-action-btn"
                           href="${pageContext.request.contextPath}/budget/set?month=${budgetMonth}&year=${budgetYear}">
                            Set Your Budget
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>

<script>
    // Create floating particles
    function createParticles() {
        const particleCount = 50;
        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            
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
