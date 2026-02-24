import os
import re

files_to_process = [
    "lib/views/analysis_screen/analysis_result_screen.dart",
    "lib/views/introduction_screen/introduction_screen.dart",
    "lib/views/analysis_screen/analysis_screen.dart",
    "lib/views/welcome_screen/welcome_screen.dart",
    "lib/views/importance_screen/importance_screen.dart",
    "lib/views/scan_screen/scan_screen.dart",
    "lib/views/camera_screen/camera_screen.dart",
    "lib/views/user_info_screen/user_info_screen.dart"
]

for file_path in files_to_process:
    if not os.path.exists(file_path):
        continue
    with open(file_path, 'r') as f:
        content = f.read()

    # Skip if already imported
    if "glassy_app_bar.dart" in content:
        continue

    # 1. Add import right before the class definition or after last import
    imports_match = list(re.finditer(r'^import .*?;$', content, re.MULTILINE))
    if imports_match:
        last_import = imports_match[-1]
        import_stmt = "\nimport '../../core/utils/widgets/glassy_app_bar.dart';"
        content = content[:last_import.end()] + import_stmt + content[last_import.end():]
    
    # 2. Add Scaffold properties
    content = re.sub(r'(return\s+Scaffold\s*\()', r'\1\n      extendBodyBehindAppBar: true,\n      appBar: const GlassyAppBar(),', content)

    # 3. Modify SafeArea( to SafeArea(top: false, 
    # except where it might already be top: false.
    # We'll just do a dumb replace if it doesn't already have top: false
    content = re.sub(r'SafeArea\(\s*(?!top: false)', r'SafeArea(\n        top: false,\n        ', content)

    with open(file_path, 'w') as f:
        f.write(content)
print("done")
