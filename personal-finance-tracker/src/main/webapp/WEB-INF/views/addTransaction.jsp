<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Transaction</title>

<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

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

    /* Home Button */
    .home-btn {
        position: absolute;
        top: 20px;
        left: 20px;
        padding: 12px 20px;
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        color: #fff;
        border: 1px solid rgba(99, 102, 241, 0.3);
        border-radius: 10px;
        text-decoration: none;
        font-weight: 700;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.3s ease;
        z-index: 100;
    }

    .home-btn:hover {
        background: rgba(99, 102, 241, 0.2);
        border-color: rgba(99, 102, 241, 0.6);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
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

    input, select, textarea {
        width: 100%;
        padding: 14px 18px;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(99, 102, 241, 0.2);
        border-radius: 12px;
        font-size: 15px;
        color: #fff;
        transition: all 0.3s ease;
        backdrop-filter: blur(10px);
        font-family: inherit;
    }

    input::placeholder, textarea::placeholder {
        color: rgba(255, 255, 255, 0.3);
    }

    input:focus, select:focus, textarea:focus {
        outline: none;
        background: rgba(255, 255, 255, 0.08);
        border-color: #6366f1;
        box-shadow: 
            0 0 20px rgba(99, 102, 241, 0.3),
            inset 0 0 10px rgba(99, 102, 241, 0.1);
    }

    select {
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23a855f7' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 15px center;
        padding-right: 40px;
    }

    select option {
        background: #1a1f3a;
        color: #fff;
        padding: 10px;
    }

    textarea {
        resize: none;
        height: 90px;
    }

    /* Error States */
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

    input.invalid, select.invalid, textarea.invalid {
        border-color: #ff6b6b;
        box-shadow: 0 0 20px rgba(255, 107, 107, 0.3);
        animation: shake 0.4s ease;
    }

    /* Submit Button */
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

    /* Error Message */
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
            padding: 10px 16px;
            font-size: 13px;
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

    <a class="home-btn" href="${pageContext.request.contextPath}/">🏠 Home</a>

    <h2>➕ Add Transaction</h2>

    <c:if test="${not empty error}">
        <div class="message error-message">${error}</div>
    </c:if>

    <form id="txnForm"
          method="post"
          action="${pageContext.request.contextPath}/transactions/add"
          onsubmit="return validateTxnForm()">

        <div class="form-group">
            <label for="amount">Amount *</label>
            <input type="number" step="0.01" id="amount" name="amount"
                   placeholder="Enter amount"
                   value="${transaction.amount != null ? transaction.amount : ''}">
            <span class="error" id="amountError">Amount must be greater than 0</span>
        </div>

        <div class="form-group">
            <label for="type">Transaction Type *</label>
            <select id="type" name="type">
                <option value="">-- Select Type --</option>
                <option value="CREDITED">CREDITED</option>
                <option value="DEBITED">DEBITED</option>
            </select>
            <span class="error" id="typeError">Please select transaction type</span>
        </div>

        <div class="form-group">
            <label for="category">Category *</label>
            <input type="text" id="category" name="category"
                   placeholder="Example: Food, Salary, Shopping">
            <span class="error" id="categoryError">Category is required</span>
        </div>

        <div class="form-group">
            <label for="description">Description (Optional)</label>
            <textarea id="description" name="description"
                      placeholder="Optional note..."></textarea>
        </div>

        <button type="submit" class="btn">Save Transaction</button>
    </form>
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

    // Original validation function - UNCHANGED
    function validateTxnForm() {
        let isValid = true;
        clearErrors();

        const amount = document.getElementById("amount").value.trim();
        const type = document.getElementById("type").value.trim();
        const category = document.getElementById("category").value.trim();

        if (amount === "" || parseFloat(amount) <= 0) {
            showError("amount", "amountError");
            isValid = false;
        }

        if (type === "") {
            showError("type", "typeError");
            isValid = false;
        }

        if (category === "" || category.length < 2) {
            showError("category", "categoryError");
            isValid = false;
        }

        return isValid;
    }

    function showError(inputId, errorId) {
        document.getElementById(inputId).classList.add("invalid");
        document.getElementById(errorId).classList.add("show");
    }

    function clearErrors() {
        document.querySelectorAll("input, select, textarea")
            .forEach(el => el.classList.remove("invalid"));

        document.querySelectorAll(".error")
            .forEach(err => err.classList.remove("show"));
    }
</script>

</body>
</html>
