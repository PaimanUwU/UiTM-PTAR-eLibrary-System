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
                <div>
                    <a href="${pageContext.request.contextPath}/login" class="bg-purple-700 hover:bg-purple-600 text-white font-medium px-5 py-2 rounded-lg transition duration-200">
                        Sign In
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

                <!-- Info Message -->
                <div class="bg-indigo-50 border border-indigo-200 text-indigo-900 rounded-xl p-4 text-sm">
                    ⚠️ Detailed eResource download links and shelf catalog copies can be unlocked after signing in.
                </div>

                <div class="pt-6 border-t border-slate-100 flex items-center justify-end">
                    <a href="${pageContext.request.contextPath}/login" class="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-6 py-3 rounded-xl shadow transition duration-150">
                        Sign In to Borrow / Access
                    </a>
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
