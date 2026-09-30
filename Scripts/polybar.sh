pkill -x polybar 2>/dev/null || true
sleep 0.1

exec polybar
