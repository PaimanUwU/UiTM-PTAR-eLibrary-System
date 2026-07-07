<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign Up - UiTM PTAR eLibrary</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-slate-100 text-slate-800 min-h-screen flex flex-col">

    <!-- Top Navigation Bar -->
    <nav class="bg-purple-900 text-white shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <div class="flex items-center">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="font-bold text-xl tracking-tight">UiTM PTAR <span class="text-purple-300">eLibrary</span></a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/login" class="bg-purple-700 hover:bg-purple-600 text-white font-medium px-4 py-2 rounded-lg transition duration-200 text-sm">
                        Sign In
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-sm border border-slate-200">
            <div class="text-center">
                <h2 class="text-3xl font-extrabold text-slate-900">Create Borrower Account</h2>
                <p class="mt-2 text-sm text-slate-600">Register as a student or staff to borrow books.</p>
            </div>

            <!-- Error Banner -->
            <c:if test="${not empty error}">
                <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded-md shadow-sm">
                    <p class="text-sm font-medium text-red-800">${error}</p>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST" class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-slate-700">Full Name</label>
                    <input type="text" name="name" required placeholder="e.g. John Doe"
                           class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 outline-none">
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700">Email Address</label>
                    <input type="email" name="email" required placeholder="e.g. john@student.uitm.edu.my"
                           class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 outline-none">
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700">Password</label>
                    <input type="password" name="password" required placeholder="••••••••"
                           class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 outline-none">
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700">Phone Number</label>
                    <input type="text" name="phone" required placeholder="e.g. 012-3456789"
                           class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 outline-none">
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700">Borrower Type</label>
                    <select name="type" required
                            class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 outline-none bg-white">
                        <option value="STUDENT">STUDENT</option>
                        <option value="STAFF">STAFF</option>
                    </select>
                </div>

                <button type="submit" class="w-full bg-purple-900 hover:bg-purple-800 text-white font-semibold py-2.5 px-4 rounded-lg shadow transition duration-150 mt-6">
                    Sign Up
                </button>

                <div class="text-center text-sm text-slate-500 mt-4">
                    Already have an account? 
                    <a href="${pageContext.request.contextPath}/login" class="text-purple-900 font-semibold hover:underline">Sign In</a>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-slate-900 text-slate-400 py-8 text-center text-sm border-t border-slate-800">
        <p>&copy; 2026 UiTM PTAR eLibrary System. All rights reserved.</p>
    </footer>

</body>
</html>
