task 'src' do
  bash <<-EOF
    for i in $(seq 3); do
      echo "$(date '+%H:%m:%S') $i"
      echo "$(date '+%H:%m:%S') (stderr) $i" >&2
      sleep 1
    done
  EOF
end

task 'step1', files: 'src' do
  bash <<-EOF
    echo "$(date '+%H:%m:%S') step1 start"
    sleep 1
    cat $src
    sleep 1
    echo "$(date '+%H:%m:%S') step1 finish"
  EOF
end

task 'step2', files: 'step1' do
  bash <<-EOF
    echo "$(date '+%H:%m:%S') step2 start"
    sleep 1
    cat $step1
    sleep 1
    echo "$(date '+%H:%m:%S') step2 finish"
  EOF
end

task 'final', files: ['src', 'step2'] do
  bash <<-EOF
    {
      echo '** step2 **'
      cat $step2
      echo '** src **'
      cat $src
    } >&2
    echo DONE
  EOF
end
