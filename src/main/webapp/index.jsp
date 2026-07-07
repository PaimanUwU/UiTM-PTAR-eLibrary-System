<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>UiTM PTAR eLibrary System</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 min-h-screen flex flex-col">

    <!-- Top Navigation Bar -->
    <nav class="bg-purple-900 text-white shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <div class="flex items-center">
                    <span class="font-bold text-xl tracking-tight">UiTM PTAR <span class="text-purple-300">eLibrary</span></span>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/login" class="bg-purple-700 hover:bg-purple-600 text-white font-medium px-5 py-2 rounded-lg transition duration-200">
                        Sign In
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content Hero Section -->
    <main class="flex-grow flex items-center justify-center py-16 px-4">
        <div class="max-w-4xl w-full text-center">
            <h1 class="text-4xl sm:text-6xl font-extrabold text-slate-900 tracking-tight mb-4">
                Welcome to <span class="text-purple-950">UiTM PTAR</span> eLibrary
            </h1>
            <p class="text-lg sm:text-xl text-slate-600 max-w-2xl mx-auto mb-8">
                Your portal to academic knowledge. Browse our extensive catalogue of physical books and ebooks.
            </p>

            <div class="flex flex-col sm:flex-row justify-center items-center gap-4">
                <a href="${pageContext.request.contextPath}/books?action=list" class="w-full sm:w-auto bg-slate-900 hover:bg-slate-800 text-white font-semibold px-8 py-4 rounded-xl shadow-lg transition duration-200 text-center">
                    Browse Books
                </a>
                <a href="${pageContext.request.contextPath}/login" class="w-full sm:w-auto bg-purple-900 hover:bg-purple-800 text-white font-semibold px-8 py-4 rounded-xl shadow-lg transition duration-200 text-center">
                    Borrower & Librarian Portal
                </a>
            </div>

            <!-- Features Summary Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mt-16">
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
                    <div class="w-12 h-12 bg-purple-100 text-purple-900 rounded-xl flex items-center justify-center font-bold text-xl mb-4 mx-auto">📚</div>
                    <h3 class="font-semibold text-lg text-slate-800 mb-2">Rich Catalogue</h3>
                    <p class="text-slate-500 text-sm">Access thousands of digital eBooks and catalogued physical books easily.</p>
                </div>
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
                    <div class="w-12 h-12 bg-purple-100 text-purple-900 rounded-xl flex items-center justify-center font-bold text-xl mb-4 mx-auto">⚡</div>
                    <h3 class="font-semibold text-lg text-slate-800 mb-2">Instant Borrowing</h3>
                    <p class="text-slate-500 text-sm">Log in as a borrower and request physical items or download online resources.</p>
                </div>
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
                    <div class="w-12 h-12 bg-purple-100 text-purple-900 rounded-xl flex items-center justify-center font-bold text-xl mb-4 mx-auto">🛡️</div>
                    <h3 class="font-semibold text-lg text-slate-800 mb-2">Easy Management</h3>
                    <p class="text-slate-500 text-sm">Librarians can easily register, update and monitor catalogued books and late returns.</p>
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