<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign In - UiTM PTAR eLibrary</title>
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
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-4xl w-full space-y-8">
            <div class="text-center">
                <h2 class="text-3xl font-extrabold text-slate-900">Sign in to your account</h2>
                <p class="mt-2 text-sm text-slate-600">Choose your portal to proceed</p>
            </div>

            <!-- Error Banner -->
            <c:if test="${not empty error}">
                <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded-md shadow-sm">
                    <div class="flex">
                        <div class="flex-shrink-0">
                            <span class="text-red-500 font-bold">⚠️</span>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-red-800">${error}</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <!-- Borrower Login Panel -->
                <div class="bg-white p-8 rounded-2xl shadow-sm border border-slate-200">
                    <div class="flex items-center gap-3 mb-6">
                        <div class="w-10 h-10 bg-indigo-100 text-indigo-900 rounded-lg flex items-center justify-center text-xl font-bold">👨‍🎓</div>
                        <h3 class="text-xl font-bold text-slate-900">Borrower Portal</h3>
                    </div>
                    <form action="${pageContext.request.contextPath}/login" method="POST" class="space-y-4">
                        <input type="hidden" name="role" value="borrower">
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Email Address</label>
                            <input type="email" name="email" required class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition duration-150">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Password</label>
                            <input type="password" name="password" required class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition duration-150">
                        </div>
                        <button type="submit" class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2.5 px-4 rounded-lg shadow transition duration-150">
                            Login as Borrower
                        </button>
                        <div class="text-center text-xs text-slate-500 mt-3">
                            New borrower? <a href="${pageContext.request.contextPath}/register" class="text-indigo-600 font-semibold hover:underline">Sign Up here</a>
                        </div>
                    </form>
                </div>

                <!-- Librarian Login Panel -->
                <div class="bg-white p-8 rounded-2xl shadow-sm border border-slate-200">
                    <div class="flex items-center gap-3 mb-6">
                        <div class="w-10 h-10 bg-purple-100 text-purple-900 rounded-lg flex items-center justify-center text-xl font-bold">🔑</div>
                        <h3 class="text-xl font-bold text-slate-900">Librarian Portal</h3>
                    </div>
                    <form action="${pageContext.request.contextPath}/login" method="POST" class="space-y-4">
                        <input type="hidden" name="role" value="librarian">
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Email Address</label>
                            <input type="email" name="email" required class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 transition duration-150">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700">Password</label>
                            <input type="password" name="password" required class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 transition duration-150">
                        </div>
                        <button type="submit" class="w-full bg-purple-900 hover:bg-purple-800 text-white font-medium py-2.5 px-4 rounded-lg shadow transition duration-150">
                            Login as Librarian
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-slate-900 text-slate-400 py-8 text-center text-sm border-t border-slate-800">
        <p>&copy; 2026 UiTM PTAR eLibrary System. All rights reserved.</p>
    </footer>

</body>
</html>
