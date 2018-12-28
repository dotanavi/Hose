task 'src' do
  bash <<-EOF
    for i in $(seq 5); do
      echo $i
      sleep 1
    done
  EOF
end

task 'step1', src: STDIN do
  bash <<-EOF
    echo step1 start
    while read -r line; do
      echo "> $line"
    done
    echo step1 end
  EOF
end

task 'step2', step1: STDIN do
  bash <<-EOF
    echo step2 start
    while read -r line; do
      echo "> $line"
    done
    echo step2 end
  EOF
end

task 'final', step2: STDIN do
  bash <<-EOF
    while read -r line; do
      echo "f> $line" >&2
    done
  EOF
end
