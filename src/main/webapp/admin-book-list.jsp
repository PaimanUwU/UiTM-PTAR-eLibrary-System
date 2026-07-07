<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Books - UiTM PTAR eLibrary</title>
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
                    <a href="${pageContext.request.contextPath}/admin/borrowed" class="text-white hover:text-purple-200 text-sm font-medium">Loans</a>
                    <a href="${pageContext.request.contextPath}/logout" class="bg-purple-700 hover:bg-purple-600 text-white font-medium px-4 py-2 rounded-lg transition duration-200 text-sm">
                        Log Out
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="flex-grow max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <div class="mb-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
            <div>
                <h1 class="text-3xl font-extrabold text-slate-900">Books Inventory</h1>
                <p class="text-slate-500 mt-1">Review catalogued ebooks and physical copies registered in the database.</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/books?action=add" class="bg-purple-900 hover:bg-purple-800 text-white font-semibold px-5 py-2.5 rounded-lg transition duration-150 text-sm flex items-center justify-center gap-1.5 shadow">
                <span>➕</span> Add New Book
            </a>
        </div>

        <!-- Success/Error Banner -->
        <c:if test="${not empty sessionScope.message}">
            <div class="bg-green-50 border-l-4 border-green-500 p-4 rounded-md shadow-sm mb-6">
                <p class="text-sm font-medium text-green-800">${sessionScope.message}</p>
                <% session.removeAttribute("message"); %>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded-md shadow-sm mb-6">
                <p class="text-sm font-medium text-red-800">${sessionScope.error}</p>
                <% session.removeAttribute("error"); %>
            </div>
        </c:if>

        <!-- Search Bar -->
        <form action="${pageContext.request.contextPath}/admin/books" method="GET" class="mb-8">
            <div class="flex flex-col sm:flex-row gap-3">
                <input type="text" name="search" placeholder="Search by title, author, or ISBN..." value="${param.search}"
                       class="flex-grow px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none transition">
                <button type="submit" class="bg-purple-900 hover:bg-purple-800 text-white font-medium px-6 py-3 rounded-xl transition duration-150">
                    Search
                </button>
            </div>
        </form>

        <!-- Books List Table -->
        <c:choose>
            <c:when test="${empty books}">
                <div class="text-center py-16 bg-white rounded-2xl border border-slate-200">
                    <p class="text-slate-500 text-lg">No books found in the inventory.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-2xl border border-slate-200 overflow-hidden shadow-sm">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-slate-200">
                            <thead class="bg-slate-50">
                                <tr>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Book ID</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Title & Author</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">ISBN</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Type</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 bg-white">
                                <c:forEach var="book" items="${books}">
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-slate-500">${book.book_id}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm font-bold text-slate-900">${book.book_title}</div>
                                            <div class="text-xs text-slate-500">by ${book.author_name} &bull; ${book.publish_year}</div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600">${book.ISBN}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600">
                                            <span class="px-2 py-0.5 text-xs font-semibold rounded-full 
                                                ${book.book_type == 'E-BOOK' ? 'bg-blue-100 text-blue-800' : 'bg-green-100 text-green-800'}">
                                                ${book.book_type}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 py-0.5 text-xs font-semibold rounded-full 
                                                ${book.book_status == 'AVAILABLE' ? 'bg-green-100 text-green-800' : 'bg-amber-100 text-amber-800'}">
                                                ${book.book_status}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <div class="flex items-center gap-3">
                                                <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${book.book_id}" class="text-amber-600 hover:text-amber-800">Edit</a>
                                                <a href="${pageContext.request.contextPath}/admin/books?action=delete&id=${book.book_id}" onclick="return confirm('Are you sure you want to delete this book?')" class="text-red-600 hover:text-red-800">Delete</a>
                                            </div>
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
