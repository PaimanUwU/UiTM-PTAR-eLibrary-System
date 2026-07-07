<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Book Details - UiTM PTAR eLibrary</title>
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
                    <a href="${pageContext.request.contextPath}/books?action=list" class="font-bold text-xl tracking-tight">UiTM PTAR <span class="text-purple-300">eLibrary</span></a>
                </div>
                <div class="flex items-center gap-4">
                    <span class="text-sm text-purple-200">Hello, <strong>${sessionScope.user.borrower_name}</strong></span>
                    <a href="${pageContext.request.contextPath}/borrow" class="text-white hover:text-purple-200 text-sm font-medium">My Borrowings</a>
                    <a href="${pageContext.request.contextPath}/logout" class="bg-purple-700 hover:bg-purple-600 text-white font-medium px-4 py-2 rounded-lg transition duration-200 text-sm">
                        Log Out
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="flex-grow max-w-4xl w-full mx-auto px-4 py-8">
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/books?action=list" class="text-purple-950 hover:text-purple-750 text-sm font-semibold flex items-center gap-1">
                &larr; Back to Catalogue
            </a>
        </div>

        <div class="bg-white rounded-2xl border border-slate-200 overflow-hidden">
            <div class="bg-slate-900 text-white px-8 py-6">
                <div class="flex items-center gap-3 mb-2">
                    <span class="px-3 py-1 text-xs font-semibold rounded-full bg-purple-700 text-purple-100">
                        ${book.book_type}
                    </span>
                    <span class="text-xs text-slate-400 font-mono">ID: ${book.book_id}</span>
                </div>
                <h1 class="text-3xl font-bold">${book.book_title}</h1>
                <p class="text-slate-350 text-lg mt-1">by <span class="text-white font-medium">${book.author_name}</span></p>
            </div>

            <div class="p-8 space-y-6">
                <!-- Book Metadata -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <h3 class="text-xs font-semibold text-slate-500 uppercase tracking-wider">ISBN</h3>
                        <p class="text-slate-800 font-medium mt-1">${book.ISBN}</p>
                    </div>
                    <div>
                        <h3 class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</h3>
                        <p class="text-slate-800 font-medium mt-1">
                            <span class="px-2.5 py-1 text-xs font-semibold rounded-full 
                                ${book.book_status == 'AVAILABLE' ? 'bg-green-100 text-green-800' : 'bg-amber-100 text-amber-800'}">
                                ${book.book_status}
                            </span>
                        </p>
                    </div>
                    <div>
                        <h3 class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Publisher</h3>
                        <p class="text-slate-800 font-medium mt-1">${book.publisher}</p>
                    </div>
                    <div>
                        <h3 class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Publish Year</h3>
                        <p class="text-slate-800 font-medium mt-1">${book.publish_year}</p>
                    </div>
                </div>

                <!-- Type Specific Meta -->
                <div class="bg-slate-50 rounded-xl p-6 border border-slate-100">
                    <c:choose>
                        <c:when test="${book.book_type == 'E-BOOK'}">
                            <h3 class="text-lg font-bold text-slate-900 mb-3">eResource Details</h3>
                            <div class="space-y-3">
                                <div>
                                    <span class="text-sm font-semibold text-slate-500">File Size:</span>
                                    <span class="text-sm text-slate-800 font-medium ml-1">${book.file_size}</span>
                                </div>
                                <div>
                                    <span class="text-sm font-semibold text-slate-500">Access Link:</span>
                                    <span class="text-sm ml-1">
                                        <a href="${book.access_link}" target="_blank" class="text-indigo-600 hover:text-indigo-850 underline">
                                            ${book.access_link}
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h3 class="text-lg font-bold text-slate-900 mb-3">Physical Copy Location</h3>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                <div>
                                    <span class="text-sm font-semibold text-slate-500 block">Shelf Location</span>
                                    <span class="text-sm text-slate-800 font-semibold">${book.shelf_location}</span>
                                </div>
                                <div>
                                    <span class="text-sm font-semibold text-slate-500 block">Accession No</span>
                                    <span class="text-sm text-slate-800 font-semibold">${book.accession_no}</span>
                                </div>
                                <div>
                                    <span class="text-sm font-semibold text-slate-500 block">Copy Number</span>
                                    <span class="text-sm text-slate-800 font-semibold">${book.copy_number}</span>
                                </div>
                                <div>
                                    <span class="text-sm font-semibold text-slate-500 block">Condition Status</span>
                                    <span class="text-sm text-slate-800 font-semibold">${book.condition_status}</span>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="pt-6 border-t border-slate-100 flex items-center justify-end">
                    <c:if test="${book.book_status == 'AVAILABLE'}">
                        <form action="${pageContext.request.contextPath}/borrow" method="POST">
                            <input type="hidden" name="action" value="request">
                            <input type="hidden" name="bookId" value="${book.book_id}">
                            <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-6 py-3 rounded-xl shadow transition duration-150">
                                Request Borrow
                            </button>
                        </form>
                    </c:if>
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
