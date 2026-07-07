<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Book - UiTM PTAR eLibrary</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
    <script>
        function toggleBookFields() {
            const type = document.getElementById("book_type").value;
            const ebookSection = document.getElementById("ebook-fields");
            const physicalSection = document.getElementById("physical-fields");
            
            const ebookInputs = ebookSection.querySelectorAll("input");
            const physicalInputs = physicalSection.querySelectorAll("input, select");

            if (type === "E-BOOK") {
                ebookSection.style.display = "block";
                physicalSection.style.display = "none";
                ebookInputs.forEach(i => i.required = true);
                physicalInputs.forEach(i => i.required = false);
            } else {
                ebookSection.style.display = "none";
                physicalSection.style.display = "block";
                ebookInputs.forEach(i => i.required = false);
                physicalInputs.forEach(i => i.required = true);
            }
        }
        window.onload = toggleBookFields;
    </script>
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
                    <a href="${pageContext.request.contextPath}/admin/books" class="text-white hover:text-purple-200 text-sm font-medium">Catalogue</a>
                    <a href="${pageContext.request.contextPath}/logout" class="bg-purple-700 hover:bg-purple-600 text-white font-medium px-4 py-2 rounded-lg transition duration-200 text-sm">
                        Log Out
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="flex-grow max-w-3xl w-full mx-auto px-4 py-8">
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/admin/books" class="text-purple-950 hover:text-purple-750 text-sm font-semibold flex items-center gap-1">
                &larr; Back to Catalogue
            </a>
        </div>

        <div class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
            <div class="bg-slate-900 text-white px-8 py-6">
                <h1 class="text-2xl font-bold">Edit Book Record</h1>
                <p class="text-slate-400 text-sm mt-1">Update fields for book ID: <span class="font-mono text-white font-bold">${book.book_id}</span></p>
            </div>

            <form action="${pageContext.request.contextPath}/admin/books" method="POST" class="p-8 space-y-6">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="book_id" value="${book.book_id}">

                <!-- Core Metadata -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Book Title</label>
                        <input type="text" name="book_title" required value="${book.book_title}"
                               class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Author Name</label>
                        <input type="text" name="author_name" required value="${book.author_name}"
                               class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Publisher</label>
                        <input type="text" name="publisher" required value="${book.publisher}"
                               class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Publish Year</label>
                        <input type="text" name="publish_year" required value="${book.publish_year}"
                               class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">ISBN</label>
                        <input type="text" name="ISBN" required value="${book.ISBN}"
                               class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Book Status</label>
                        <select name="book_status" required
                                class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none bg-white">
                            <option value="AVAILABLE" ${book.book_status == 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
                            <option value="BORROWED" ${book.book_status == 'BORROWED' ? 'selected' : ''}>BORROWED</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Book Type</label>
                        <select id="book_type" name="book_type" required onchange="toggleBookFields()"
                                class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none bg-white font-semibold">
                            <option value="PHYSICAL_BOOK" ${book.book_type == 'PHYSICAL_BOOK' ? 'selected' : ''}>PHYSICAL BOOK</option>
                            <option value="E-BOOK" ${book.book_type == 'E-BOOK' ? 'selected' : ''}>E-BOOK</option>
                        </select>
                    </div>
                </div>

                <!-- Subclass: E-Book Fields -->
                <div id="ebook-fields" class="bg-blue-50 border border-blue-200 rounded-xl p-6 space-y-4" 
                     style="display: ${book.book_type == 'E-BOOK' ? 'block' : 'none'};">
                    <h3 class="text-sm font-bold text-blue-900 uppercase tracking-wider">E-Book Specific Details</h3>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-750">File Size</label>
                            <input type="text" name="file_size" value="${book.file_size}"
                                   class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none bg-white">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-750">Access Link</label>
                            <input type="text" name="access_link" value="${book.access_link}"
                                   class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none bg-white">
                        </div>
                    </div>
                </div>

                <!-- Subclass: Physical Book Fields -->
                <div id="physical-fields" class="bg-green-50 border border-green-200 rounded-xl p-6 space-y-4"
                     style="display: ${book.book_type == 'PHYSICAL_BOOK' ? 'block' : 'none'};">
                    <h3 class="text-sm font-bold text-green-900 uppercase tracking-wider">Physical Copy Details</h3>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-750">Shelf Location</label>
                            <input type="text" name="shelf_location" value="${book.shelf_location}"
                                   class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none bg-white">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-750">Accession No</label>
                            <input type="text" name="accession_no" value="${book.accession_no}"
                                   class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none bg-white">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-750">Copy Number</label>
                            <input type="number" name="copy_number" value="${book.copy_number != null ? book.copy_number : 1}" min="1"
                                   class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none bg-white">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-750">Condition Status</label>
                            <input type="text" name="condition_status" value="${book.condition_status}"
                                   class="mt-1 block w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none bg-white">
                        </div>
                    </div>
                </div>

                <div class="pt-6 border-t border-slate-100 flex items-center justify-end gap-3">
                    <a href="${pageContext.request.contextPath}/admin/books" class="bg-slate-200 hover:bg-slate-300 text-slate-700 font-semibold px-6 py-2.5 rounded-lg transition text-sm">
                        Cancel
                    </a>
                    <button type="submit" class="bg-purple-900 hover:bg-purple-800 text-white font-semibold px-6 py-2.5 rounded-lg transition text-sm shadow">
                        Update Book Record
                    </button>
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
