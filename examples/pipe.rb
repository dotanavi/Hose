task 'src' do
  bash <<-EOF
    for i in $(seq 3); do
      echo $i
      sleep 1
    done
  EOF
end

task 'step1', in: 'src' do
  bash <<-EOF
    echo step1 start
    while read -r line; do
      echo "> $line"
    done
    echo step1 end
  EOF
end

task 'step2', in: 'step1' do
  bash <<-EOF
    echo step2 start
    while read -r line; do
      echo "> $line"
    done
    echo step2 end
  EOF
end

task 'final', in: 'step2' do
  bash <<-EOF
    while read -r line; do
      echo "f> $line" >&2
    done
    echo DONE
  EOF
end
