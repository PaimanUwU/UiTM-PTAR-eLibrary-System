<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Late List - UiTM PTAR eLibrary</title>
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
                <div class="flex items-center flex-shrink-0">
                    <a href="${pageContext.request.contextPath}/admin/panel" class="font-bold text-xl tracking-tight">UiTM PTAR <span class="text-purple-300 text-sm font-semibold uppercase tracking-wider ml-1">Librarian Office</span></a>
                </div>
                <div class="flex items-center gap-4">
                    <a href="${pageContext.request.contextPath}/admin/panel" class="text-white hover:text-purple-200 text-sm font-medium">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/books" class="text-white hover:text-purple-200 text-sm font-medium">Catalogue</a>
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
            <div class="flex items-center gap-2">
                <h1 class="text-3xl font-extrabold text-slate-900">Overdue Returns</h1>
                <span class="bg-red-100 text-red-800 font-bold text-xs px-2.5 py-1 rounded-full">ACTION REQUIRED</span>
            </div>
            <p class="text-slate-500 mt-1">Review student borrowings that have exceeded their 14-day loan window.</p>
        </div>

        <!-- Overdues Table -->
        <c:choose>
            <c:when test="${empty late}">
                <div class="text-center py-16 bg-white rounded-2xl border border-slate-200 shadow-sm">
                    <p class="text-slate-500 text-lg">🎉 Great news! There are no overdue loan records at this time.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-2xl border border-red-200 overflow-hidden shadow-sm">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-slate-200">
                            <thead class="bg-slate-50">
                                <tr>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Borrow ID</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Borrower</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Book Title</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Borrow Date</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Due Date</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Action</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 bg-white">
                                <c:forEach var="loan" items="${late}">
                                    <tr class="bg-red-50/30 hover:bg-red-50/50 transition duration-100">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-red-900">${loan.borrow_id}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-900">
                                            <div class="font-bold text-red-950">${loan.borrower_name}</div>
                                            <div class="text-xs text-slate-500">ID: ${loan.borrower_id}</div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-slate-900">${loan.book_title}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600">${loan.borrow_date}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-red-600 font-bold">${loan.due_date}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm">
                                            <form action="${pageContext.request.contextPath}/admin/borrowed" method="POST" class="inline">
                                                <input type="hidden" name="action" value="return">
                                                <input type="hidden" name="borrowId" value="${loan.borrow_id}">
                                                <input type="hidden" name="bookId" value="${loan.book_id}">
                                                <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-medium text-xs px-3 py-1.5 rounded-lg transition duration-150 shadow-sm">
                                                    Process Return
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <!-- Footer -->
    <footer class="bg-slate-900 text-slate-400 py-8 text-center text-sm border-t border-slate-800">
        <p>&copy; 2026 UiTM PTAR eLibrary System. All rights reserved.</p>
    </footer>

</body>
</html>
