<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Librarian Dashboard - UiTM PTAR eLibrary</title>
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
                    <a href="${pageContext.request.contextPath}/admin/panel" class="font-bold text-xl tracking-tight">UiTM PTAR <span class="text-purple-300 text-sm font-semibold uppercase tracking-wider ml-1">Librarian Office</span></a>
                </div>
                <div class="flex items-center gap-4">
                    <span class="text-sm text-purple-200">Hello, <strong>${sessionScope.admin.librarian_name}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="bg-purple-700 hover:bg-purple-600 text-white font-medium px-4 py-2 rounded-lg transition duration-200 text-sm">
                        Log Out
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="flex-grow max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <div class="mb-8">
            <h1 class="text-3xl font-extrabold text-slate-900">Dashboard</h1>
            <p class="text-slate-500 mt-1">Manage library records, books catalogue, and trace borrowed inventory.</p>
        </div>

        <!-- Quick Summary Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white p-6 rounded-2xl border border-slate-200 shadow-sm flex items-center justify-between">
                <div>
                    <span class="text-xs font-semibold text-slate-500 uppercase tracking-wider block">Total Books</span>
                    <span class="text-3xl font-bold text-slate-900 mt-1">${totalBooks}</span>
                </div>
                <div class="w-12 h-12 bg-purple-100 text-purple-900 rounded-xl flex items-center justify-center font-bold text-xl">📚</div>
            </div>
            <div class="bg-white p-6 rounded-2xl border border-slate-200 shadow-sm flex items-center justify-between">
                <div>
                    <span class="text-xs font-semibold text-slate-500 uppercase tracking-wider block">Active Loans</span>
                    <span class="text-3xl font-bold text-slate-900 mt-1">${totalLoans}</span>
                </div>
                <div class="w-12 h-12 bg-blue-100 text-blue-900 rounded-xl flex items-center justify-center font-bold text-xl">🤝</div>
            </div>
            <div class="bg-white p-6 rounded-2xl border border-slate-200 shadow-sm flex items-center justify-between">
                <div>
                    <span class="text-xs font-semibold text-slate-500 uppercase tracking-wider block">Overdue Items</span>
                    <span class="text-3xl font-bold text-red-600 mt-1">${totalLate}</span>
                </div>
                <div class="w-12 h-12 bg-red-100 text-red-900 rounded-xl flex items-center justify-center font-bold text-xl">⚠️</div>
            </div>
        </div>

        <!-- Navigation Grid -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <!-- Book list -->
            <a href="${pageContext.request.contextPath}/admin/books" class="bg-white hover:border-purple-600 border border-slate-200 rounded-2xl p-6 shadow-sm flex flex-col justify-between group transition duration-150">
                <div>
                    <div class="w-10 h-10 bg-slate-100 group-hover:bg-purple-100 rounded-lg flex items-center justify-center text-xl mb-4 transition duration-150">📖</div>
                    <h3 class="font-bold text-lg text-slate-900">Books List</h3>
                    <p class="text-slate-500 text-sm mt-1">View, search, edit and remove books from the system.</p>
                </div>
                <span class="text-purple-900 font-semibold text-sm mt-4 inline-flex items-center gap-1 group-hover:gap-2 transition-all">Manage Catalog &rarr;</span>
            </a>

            <!-- Add book -->
            <a href="${pageContext.request.contextPath}/admin/books?action=add" class="bg-white hover:border-purple-600 border border-slate-200 rounded-2xl p-6 shadow-sm flex flex-col justify-between group transition duration-150">
                <div>
                    <div class="w-10 h-10 bg-slate-100 group-hover:bg-purple-100 rounded-lg flex items-center justify-center text-xl mb-4 transition duration-150">➕</div>
                    <h3 class="font-bold text-lg text-slate-900">Add Book</h3>
                    <p class="text-slate-500 text-sm mt-1">Register new eBook or physical copy records into database.</p>
                </div>
                <span class="text-purple-900 font-semibold text-sm mt-4 inline-flex items-center gap-1 group-hover:gap-2 transition-all">Add Book &rarr;</span>
            </a>

            <!-- Borrowed -->
            <a href="${pageContext.request.contextPath}/admin/borrowed" class="bg-white hover:border-purple-600 border border-slate-200 rounded-2xl p-6 shadow-sm flex flex-col justify-between group transition duration-150">
                <div>
                    <div class="w-10 h-10 bg-slate-100 group-hover:bg-purple-100 rounded-lg flex items-center justify-center text-xl mb-4 transition duration-150">📋</div>
                    <h3 class="font-bold text-lg text-slate-900">Loans Tracker</h3>
                    <p class="text-slate-500 text-sm mt-1">Track current active borrowed books and process returns.</p>
                </div>
                <span class="text-purple-900 font-semibold text-sm mt-4 inline-flex items-center gap-1 group-hover:gap-2 transition-all">Track Loans &rarr;</span>
            </a>

            <!-- Late list -->
            <a href="${pageContext.request.contextPath}/admin/late" class="bg-white hover:border-purple-600 border border-slate-200 rounded-2xl p-6 shadow-sm flex flex-col justify-between group transition duration-150">
                <div>
                    <div class="w-10 h-10 bg-slate-100 group-hover:bg-purple-100 rounded-lg flex items-center justify-center text-xl mb-4 transition duration-150">🚨</div>
                    <h3 class="font-bold text-lg text-slate-900">Late List</h3>
                    <p class="text-slate-500 text-sm mt-1">Monitor borrowers who have not returned books on time.</p>
                </div>
                <span class="text-purple-900 font-semibold text-sm mt-4 inline-flex items-center gap-1 group-hover:gap-2 transition-all">View Overdues &rarr;</span>
            </a>
        </div>

    </main>

    <!-- Footer -->
    <footer class="bg-slate-900 text-slate-400 py-8 text-center text-sm border-t border-slate-800">
        <p>&copy; 2026 UiTM PTAR eLibrary System. All rights reserved.</p>
    </footer>

</body>
</html>
