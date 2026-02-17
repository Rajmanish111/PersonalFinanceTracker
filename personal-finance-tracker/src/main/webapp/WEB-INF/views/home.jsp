<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personal Finance Tracker - Home</title>
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
            position: relative;
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

        .container {
            position: relative;
            z-index: 2;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        /* Glowing Title Section */
        .header {
            text-align: center;
            margin-bottom: 80px;
            animation: fadeInDown 1s ease-out;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .title-wrapper {
            position: relative;
            display: inline-block;
        }

        .header h1 {
            font-size: clamp(2.5rem, 5vw, 4rem);
            font-weight: 800;
            background: linear-gradient(135deg, #6366f1, #a855f7, #ec4899);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: gradientFlow 3s ease infinite;
            position: relative;
            letter-spacing: -2px;
            margin-bottom: 20px;
        }

        @keyframes gradientFlow {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .header .subtitle {
            font-size: clamp(1rem, 2vw, 1.3rem);
            color: rgba(255, 255, 255, 0.7);
            font-weight: 300;
            letter-spacing: 1px;
            animation: fadeIn 1s ease-out 0.3s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Features Section */
        .features {
            display: flex;
            gap: 40px;
            max-width: 1000px;
            margin-bottom: 80px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 24px;
            padding: 50px 40px;
            width: 350px;
            position: relative;
            overflow: hidden;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            animation: fadeInUp 0.8s ease-out both;
            cursor: pointer;
        }

        .feature-card:nth-child(1) {
            animation-delay: 0.2s;
        }

        .feature-card:nth-child(2) {
            animation-delay: 0.4s;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(99, 102, 241, 0.1) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .feature-card:hover::before {
            opacity: 1;
            animation: rotate 8s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .feature-card:hover {
            transform: translateY(-15px) scale(1.05);
            border-color: rgba(99, 102, 241, 0.5);
            box-shadow: 
                0 20px 60px rgba(99, 102, 241, 0.3),
                0 0 40px rgba(168, 85, 247, 0.2),
                inset 0 0 20px rgba(99, 102, 241, 0.1);
        }

        .feature-icon {
            font-size: 4rem;
            margin-bottom: 25px;
            display: inline-block;
            animation: float 3s ease-in-out infinite;
            filter: drop-shadow(0 0 20px rgba(99, 102, 241, 0.5));
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
        }

        .feature-card:hover .feature-icon {
            animation: pulse 1s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.15); }
        }

        .feature-card h3 {
            color: #fff;
            margin-bottom: 15px;
            font-size: 1.8rem;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }

        .feature-card p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 1rem;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }

        /* Holographic Line Effect */
        .feature-card::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, 
                transparent,
                rgba(99, 102, 241, 0.8),
                rgba(168, 85, 247, 0.8),
                rgba(236, 72, 153, 0.8),
                transparent
            );
            transform: translateX(-100%);
            transition: transform 0.6s ease;
        }

        .feature-card:hover::after {
            transform: translateX(100%);
        }

        /* CTA Section */
        .cta-section {
            text-align: center;
            animation: fadeInUp 1s ease-out 0.6s both;
        }

        .cta-button {
            display: inline-block;
            background: linear-gradient(135deg, #6366f1, #a855f7);
            color: white;
            padding: 20px 60px;
            border-radius: 50px;
            text-decoration: none;
            font-size: 1.2rem;
            font-weight: 700;
            transition: all 0.3s ease;
            box-shadow: 
                0 10px 40px rgba(99, 102, 241, 0.4),
                0 0 20px rgba(168, 85, 247, 0.3);
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .cta-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .cta-button:hover::before {
            left: 100%;
        }

        .cta-button:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 
                0 20px 60px rgba(99, 102, 241, 0.6),
                0 0 40px rgba(168, 85, 247, 0.5);
        }

        .cta-button:active {
            transform: translateY(-2px) scale(1.02);
        }

        .login-link {
            margin-top: 30px;
            color: rgba(255, 255, 255, 0.5);
            font-size: 1rem;
        }

        .login-link a {
            color: #a855f7;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #6366f1, #a855f7);
            transition: width 0.3s ease;
        }

        .login-link a:hover {
            color: #ec4899;
        }

        .login-link a:hover::after {
            width: 100%;
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
            left: -200px;
        }

        .orb-2 {
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, #a855f7, transparent);
            bottom: -250px;
            right: -250px;
            animation-delay: -10s;
        }

        .orb-3 {
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, #ec4899, transparent);
            top: 50%;
            left: 50%;
            animation-delay: -5s;
        }

        @keyframes orbFloat {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(50px, -50px) scale(1.1); }
            66% { transform: translate(-50px, 50px) scale(0.9); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .features {
                gap: 30px;
            }

            .feature-card {
                width: 100%;
                max-width: 400px;
                padding: 40px 30px;
            }

            .cta-button {
                padding: 18px 50px;
                font-size: 1rem;
            }

            .header {
                margin-bottom: 60px;
            }
        }

        /* Scanline Effect */
        @keyframes scanline {
            0% { transform: translateY(-100%); }
            100% { transform: translateY(100vh); }
        }

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

    <!-- Main Container -->
    <div class="container">
        <div class="header">
            <div class="title-wrapper">
                <h1>💰 Personal Finance Tracker</h1>
            </div>
            <p class="subtitle">Take control of your financial future with smart money management</p>
        </div>

        <div class="features">
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3>Track Expenses</h3>
                <p>Monitor your spending habits and identify areas for improvement with real-time analytics</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">💵</div>
                <h3>Budget Planning</h3>
                <p>Create and manage budgets to achieve your financial goals with intelligent forecasting</p>
            </div>
        </div>

        <div class="cta-section">
            <a href="${pageContext.request.contextPath}/users/register" class="cta-button">
                Get Started - It's Free
            </a>
            <div class="login-link">
                Already have an account? <a href="${pageContext.request.contextPath}/users/login">Sign In</a>
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

        // Parallax effect on mouse move
        document.addEventListener('mousemove', (e) => {
            const moveX = (e.clientX - window.innerWidth / 2) * 0.01;
            const moveY = (e.clientY - window.innerHeight / 2) * 0.01;
            
            document.querySelectorAll('.feature-card').forEach((card, index) => {
                const speed = (index + 1) * 0.5;
                card.style.transform = `translate(${moveX * speed}px, ${moveY * speed}px)`;
            });
        });

        // Initialize particles on load
        window.addEventListener('load', createParticles);

        // Add glitch effect on title occasionally
        setInterval(() => {
            const title = document.querySelector('.header h1');
            title.style.textShadow = '2px 2px #ff00ff, -2px -2px #00ffff';
            setTimeout(() => {
                title.style.textShadow = 'none';
            }, 100);
        }, 5000);
    </script>
</body>
</html>
