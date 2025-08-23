{pkgs, ...}:
with pkgs; [
  # --- Компилятор и система сборки ---
  gcc
  cmake
  pkg-config

  # --- Отладка и анализ ---
  gdb
  valgrind
  strace
  ltrace
  cppcheck

  # --- Тестирование и покрытие ---
  check
  lcov

  ncurses

  # --- Справочная информация ---
  man-pages
]
