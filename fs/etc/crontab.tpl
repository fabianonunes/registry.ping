{{- $schedule := getenv "PINGR_SCHEDULE" "15 22 * * *" }}
{{ $schedule }} ping-all-cluster-images
