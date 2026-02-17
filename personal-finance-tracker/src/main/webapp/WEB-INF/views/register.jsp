<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Personal Finance Tracker</title>
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
            position: relative;
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
            animation: orbFloat 20s ease-in-out infinite;
        }

        .orb-1 {
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, #6366f1, transparent);
            top: -200px;
            right: -200px;
        }

        .orb-2 {
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, #a855f7, transparent);
            bottom: -250px;
            left: -250px;
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

        /* Home Button */
        .home-btn {
            position: absolute;
            top: 25px;
            left: 25px;
            padding: 14px 28px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            color: #fff;
            border: 1px solid rgba(99, 102, 241, 0.3);
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            z-index: 100;
        }

        .home-btn:hover {
            transform: translateY(-3px);
            background: rgba(99, 102, 241, 0.2);
            border-color: rgba(99, 102, 241, 0.6);
            box-shadow: 
                0 12px 40px rgba(99, 102, 241, 0.4),
                0 0 20px rgba(99, 102, 241, 0.3);
        }
        
        /* Main Container */
        .container {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            padding: 50px 45px;
            border-radius: 24px;
            border: 1px solid rgba(99, 102, 241, 0.2);
            box-shadow: 
                0 20px 60px rgba(0, 0, 0, 0.5),
                0 0 40px rgba(99, 102, 241, 0.1),
                inset 0 0 20px rgba(99, 102, 241, 0.05);
            width: 100%;
            max-width: 480px;
            position: relative;
            z-index: 10;
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
        
        input[type="text"],
        input[type="email"],
        input[type="password"] {
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

        input[type="text"]::placeholder,
        input[type="email"]::placeholder,
        input[type="password"]::placeholder {
            color: rgba(255, 255, 255, 0.3);
        }
        
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.08);
            border-color: #6366f1;
            box-shadow: 
                0 0 20px rgba(99, 102, 241, 0.3),
                inset 0 0 10px rgba(99, 102, 241, 0.1);
        }
        
        .error {
            color: #ff6b6b;
            font-size: 12px;
            margin-top: 8px;
            display: none;
            font-weight: 500;
            text-shadow: 0 0 10px rgba(255, 107, 107, 0.5);
        }
        
        .error.show {
            display: block;
            animation: shake 0.4s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        
        input.invalid {
            border-color: #ff6b6b;
            box-shadow: 0 0 20px rgba(255, 107, 107, 0.3);
            animation: shake 0.4s ease;
        }
        
        .btn {
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

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn:hover::before {
            left: 100%;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 
                0 15px 40px rgba(99, 102, 241, 0.6),
                0 0 30px rgba(168, 85, 247, 0.4);
        }
        
        .btn:active {
            transform: translateY(-1px);
        }
        
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
        
        .success {
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
            box-shadow: 0 0 20px rgba(16, 185, 129, 0.2);
        }
        
        .error-message {
            background: rgba(239, 68, 68, 0.15);
            color: #ff6b6b;
            border: 1px solid rgba(239, 68, 68, 0.3);
            box-shadow: 0 0 20px rgba(239, 68, 68, 0.2);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 40px 30px;
            }

            h2 {
                font-size: 28px;
            }

            .home-btn {
                padding: 12px 22px;
                font-size: 14px;
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

    <!-- Home Button -->
    <a class="home-btn" href="${pageContext.request.contextPath}/">🏠 Home</a>

    <div class="container">
        <h2>Create Account</h2>
        
        <!-- Success Message -->
        <c:if test="${not empty message}">
            <div class="message success">${message}</div>
        </c:if>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="message error-message">${error}</div>
        </c:if>
        
        <!-- Registration Form -->
        <form id="registrationForm" 
              method="post" 
              action="${pageContext.request.contextPath}/users/register"
              onsubmit="return validateForm()">
            
            <div class="form-group">
                <label for="name">Full Name *</label>
                <input type="text" 
                       id="name" 
                       name="name" 
                       placeholder="Enter your full name" 
                       maxlength="50"
                       value="${user.name != null ? user.name : ''}">
                <span class="error" id="nameError">Please enter a valid name (minimum 3 characters)</span>
            </div>
            
            <div class="form-group">
                <label for="email">Email Address *</label>
                <input type="email" 
                       id="email" 
                       name="email" 
                       placeholder="Enter your email" 
                       maxlength="100"
                       value="${user.email != null ? user.email : ''}">
                <span class="error" id="emailError">Please enter a valid email address</span>
            </div>
            
            <div class="form-group">
                <label for="password">Password *</label>
                <input type="password" 
                       id="password" 
                       name="password" 
                       placeholder="Enter your password" 
                       maxlength="255">
                <span class="error" id="passwordError">Password must be at least 6 characters long</span>
            </div>
            
            <button type="submit" class="btn">Register</button>
        </form>
    </div>
    
    <script>
        // Create floating particles
        function createParticles() {
            const particleCount = 40;
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.top = Math.random() * 100 + '%';
                particle.style.animationDuration = (Math.random() * 3 + 2) + 's';
                particle.style.animationDelay = Math.random() * 2 + 's';
                
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

        // Original validation function - UNCHANGED
        function validateForm() {
            let isValid = true;
            
            // Clear previous errors
            clearErrors();
            
            // Get form values
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            
            // Validate name
            if (name === '' || name.length < 3) {
                showError('name', 'nameError');
                isValid = false;
            }
            
            // Validate email
            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (email === '' || !emailPattern.test(email)) {
                showError('email', 'emailError');
                isValid = false;
            }
            
            // Validate password
            if (password === '' || password.length < 6) {
                showError('password', 'passwordError');
                isValid = false;
            }
            
            return isValid;
        }
        
        function showError(inputId, errorId) {
            document.getElementById(inputId).classList.add('invalid');
            document.getElementById(errorId).classList.add('show');
        }
        
        function clearErrors() {
            const inputs = document.querySelectorAll('input');
            const errors = document.querySelectorAll('.error');
            
            inputs.forEach(input => input.classList.remove('invalid'));
            errors.forEach(error => error.classList.remove('show'));
        }
        
        // Real-time validation
        document.getElementById('name').addEventListener('blur', function() {
            if (this.value.trim().length >= 3) {
                this.classList.remove('invalid');
                document.getElementById('nameError').classList.remove('show');
            }
        });
        
        document.getElementById('email').addEventListener('blur', function() {
            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (emailPattern.test(this.value.trim())) {
                this.classList.remove('invalid');
                document.getElementById('emailError').classList.remove('show');
            }
        });
        
        document.getElementById('password').addEventListener('blur', function() {
            if (this.value.length >= 6) {
                this.classList.remove('invalid');
                document.getElementById('passwordError').classList.remove('show');
            }
        });
    </script>
</body>
</html>
