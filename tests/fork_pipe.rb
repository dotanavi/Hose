
r, w = IO.pipe
pid = fork do
  w.close
  $stdin.reopen(r)
  exec("cat", "-")
end
r.close

w.puts "foo"
w.puts "bar"
w.puts "baz"
w.close
puts "w.close"
Process.wait
