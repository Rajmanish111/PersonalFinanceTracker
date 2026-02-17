<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Set Monthly Budget</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            overflow: hidden;
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

        .orb-3 {
            width: 350px;
            height: 350px;
            background: radial-gradient(circle, #ec4899, transparent);
            top: 40%;
            right: 15%;
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

        /* Main Container */
        .container {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 24px;
            padding: 50px 45px;
            width: 100%;
            max-width: 550px;
            position: relative;
            z-index: 10;
            box-shadow: 
                0 20px 60px rgba(0, 0, 0, 0.5),
                0 0 40px rgba(99, 102, 241, 0.1),
                inset 0 0 20px rgba(99, 102, 241, 0.05);
            animation: fadeInUp 0.8s ease-out;
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

        /* Glowing border effect */
        .container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #6366f1, #a855f7, #ec4899, #6366f1);
            background-size: 400% 400%;
            border-radius: 24px;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s ease;
            animation: gradientRotate 8s ease infinite;
        }

        .container:hover::before {
            opacity: 0.3;
        }

        @keyframes gradientRotate {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        /* Title */
        h2 {
            text-align: center;
            color: #fff;
            margin-bottom: 35px;
            font-size: 32px;
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

        /* Messages */
        .message {
            padding: 14px;
            border-radius: 12px;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 600;
            animation: slideDown 0.5s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message-success {
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
            box-shadow: 0 0 20px rgba(16, 185, 129, 0.2);
        }

        .message-error {
            background: rgba(239, 68, 68, 0.15);
            color: #ff6b6b;
            border: 1px solid rgba(239, 68, 68, 0.3);
            box-shadow: 0 0 20px rgba(239, 68, 68, 0.2);
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        input[type="number"] {
            width: 100%;
            padding: 14px 18px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 12px;
            font-size: 15px;
            color: #fff;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        input[type="number"]::placeholder {
            color: rgba(255, 255, 255, 0.3);
        }

        input[type="number"]:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.08);
            border-color: #6366f1;
            box-shadow: 
                0 0 20px rgba(99, 102, 241, 0.3),
                inset 0 0 10px rgba(99, 102, 241, 0.1);
        }

        /* Special styling for month/year grid */
        .date-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 25px;
        }

        /* Info Badge */
        .info-badge {
            display: inline-block;
            margin-left: 8px;
            padding: 2px 8px;
            background: rgba(99, 102, 241, 0.15);
            border: 1px solid rgba(99, 102, 241, 0.3);
            border-radius: 6px;
            font-size: 10px;
            color: #6366f1;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Submit Button */
        button[type="submit"] {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #6366f1, #a855f7);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 15px;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
        }

        button[type="submit"]::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        button[type="submit"]:hover::before {
            left: 100%;
        }

        button[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 
                0 15px 40px rgba(99, 102, 241, 0.6),
                0 0 30px rgba(168, 85, 247, 0.4);
        }

        button[type="submit"]:active {
            transform: translateY(-1px);
        }

        /* Back Link */
        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #a855f7;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            font-size: 15px;
        }

        .back-link::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #6366f1, #a855f7);
            transition: width 0.3s ease;
        }

        .back-link:hover {
            color: #ec4899;
        }

        .back-link:hover::after {
            width: 100%;
        }

        /* Budget Icon Animation */
        .budget-icon {
            text-align: center;
            font-size: 48px;
            margin-bottom: 20px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 40px 30px;
            }

            h2 {
                font-size: 28px;
            }

            .date-grid {
                grid-template-columns: 1fr;
                gap: 15px;
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

<div class="container">
    
    <div class="budget-icon">🎯</div>
    
    <h2>Set / Update Monthly Budget</h2>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <p class="message message-success">${message}</p>
    </c:if>

    <c:if test="${not empty error}">
        <p class="message message-error">${error}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/budget/set" method="post">

        <div class="date-grid">
            <div class="form-group">
                <label>Month <span class="info-badge">1-12</span></label>
                <input type="number" name="month" value="${month}" min="1" max="12" required />
            </div>

            <div class="form-group">
                <label>Year <span class="info-badge">2000-2100</span></label>
                <input type="number" name="year" value="${year}" min="2000" max="2100" required />
            </div>
        </div>

        <div class="form-group">
            <label>Budget Amount</label>
            <input type="number" name="amount"
                   value="<c:out value='${budget != null ? budget.amount : ""}'/>"
                   step="0.01" required />
        </div>

        <button type="submit">
            <c:choose>
                <c:when test="${budget != null}">
                    Update Budget
                </c:when>
                <c:otherwise>
                    Set Budget
                </c:otherwise>
            </c:choose>
        </button>
    </form>

    <a href="${pageContext.request.contextPath}/user/dashboard" class="back-link">
        ← Back to Dashboard
    </a>
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
