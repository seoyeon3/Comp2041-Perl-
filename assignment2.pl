#!/usr/bin/perl
while (my $line = <STDIN>) {
    chomp $line;
    push @input, $line;
}
$command = $ARGV[0];
#print "command is $command\n";
$real_option = 'x';

if ($command =~ /s/) {
	$real_option = "s";
}

#print "real option is $real_option\n";

$command =~ s/\///g;
#print $command, "\n";
$command =~ /(.*\w*)(\w{1})/;
$n = $#input;
$limit = $1;
$option = $2;
#print "Limit is $limit, and option is $option\n";
$f_letter = substr($limit,0,1);
# $s_letter = substr($limit,1,1);

#print "First letter is $f_letter\n";
#print "Seconde letter is $s_letter\n";




sub address {
	my @input = shift;
	my $start = shift;
	my $end = shift;
	$i = 0;
	while ($i <= $#input) {
		if ($input[$i] =~ /$start/) {
			$i++;
			while (1) {
				if ($input[$i] =~ /$end/ || $i >= $#input) {
					last;
				}
				$i++;
			}
			$i++;
		}
		else {
			print "$input[$i] \n";
			$i++;
		}
	}
}

if ($option eq "q") {
     $f_letter = substr($limit,0,1);
     $s_letter = substr($limit,1,1);
    if ($f_letter =~ /\d/ && $s_letter ne "{" ) {
        $i = 0;
        $j = 0;
        while ($i <= $n) {
            if ($j < $limit) {
                print $input[$i], "\n";
            }
            $i++;
            $j++;
        }
    }
    else {
            $i = 0;
            foreach $line (@input) {
                if ($line =~/$limit/) {
                    last;
					 }
                $i++;
        }
#           print "i is $i \n";
            $j=0;
            while ($j <= $i) {
                print $input[$j], "\n";
                $j++;
            }
        }
}
if ($option eq "p" && $#ARGV == 0) { #p with no n_option

	if ($limit eq "\$") { #subset1 address #
#	print "hi\n";
#		$n = $#input;
		foreach $line (@input) {
			print $line, "\n";
			if ($line eq $input[$n]) {
				print $line, "\n";
			}
		}
	}

    elsif ($limit =~ /^\d/) { #start with number
#       $i = 0;
        $target= $limit - 1;
        foreach $line (@input) {
            print $line, "\n";
            if ($line eq $input[$target]){
                print "$line\n";
            }
        }
    }
    elsif ($limit eq "") { 
        foreach $line (@input) {
            print $line, "\n";
            print $line, "\n";
        }
    }
    else {  #start with not number and empty
        foreach $line (@input) {
            print $line, "\n";
            if ($line =~ $limit) {
                print $line, "\n";
            }
        }
    }
}

if ($#ARGV == 1) { #n_option
#   $n_option = $ARGV[0];
    $command = $ARGV[1];
    $command =~ s/\///g;
    $command =~ /(.*\w*)(\w{1})/;
    $limit = $1;
    $option = $2;
#   print "limit is $limit and option is $option\n";
   

    if ($option eq "p") { #p with n_option
		if ($limit eq "\$") { #subset1 address #
#	$n = $#input;
			print $input[$n], "\n";
		}
        elsif ($limit =~ /^\d/) {
            $target = $limit - 1;
            foreach $line (@input) {
                if ($line eq $input[$target]) {
                    print $line, "\n";
                }
            }
        }

        else {
            foreach $line (@input) {
                if ($line =~ /$limit/) {
                    print $line, "\n";
                }
            }
        }
    }
}

if ($option eq "d") {
#   print "hi I am delete\n";
#   print "limit is $limit\n";
	if ($limit eq "\$") { # $ address
		foreach $line (@input) {
			if ($line ne $input[$n]) {
				print $line, "\n";
			}
		}	
	}
    elsif ($limit =~ /^\d/) { #limit start with number
		$command = $ARGV[0];
		$command =~ /(.*)d/;
		$limit = $1;
#		print "limit is $limit\n";
        if ($limit =~ /,/) { #limit include ,
			$limit =~ /(.*),(.*)/;
			$start = $1;
			$end = $2;
#	print "start is $start and end is $end\n";
			$s_slash = $e_slash = 0;
			if ($start =~ /\//) {
				$s_slash = 1;	
			}
			if ($end =~ /\//) {
				$e_slash = 1;
			}
#			print "start slash is $s_slash and end slash is $e_slash\n";
			
				if ($s_slash == 0 && $e_slash == 0 ){
#					print "yes\n";
#					$i = 0;

					while ($i < $start-1) {
						print $input[$i], "\n";
						$i++
					}
					$i = $end;
					while ($i <= $#input) {
						print $input[$i], "\n";
						$i++;
					}
					
				}

if ($s_slash == 1 && $e_slash == 0) {
#                   print "start is $start\n";
                    $start =~ s/\///g;
                    $i = 0;
                    while ($i <= $#input) {
                        if ($input[$i] =~ /$start/) {
                            last;
                        }
                        $i++;
                    }
                    #print "i is $i\n";
                    $j = 0;
                    while ($j < $i) {
                        print $input[$j], "\n";
                        $j++;
                    }
#                   print "start is $start\n";
                    while ($end <= $#input) {
#                       print $input[$end], "\n";
                        if ($input[$end] =~ /$start/) {
#                           print "hey\n";
                        }
                        else {
                            print $input[$end], "\n";
                        }
                        $end++;
                    }

                }
                if ($s_slash == 0 && $e_slash == 1) {
                    $i = 0;
                    $end =~ s/\///g;
                    while ($i < $start -1){
                        print $input[$i], "\n";
                        $i++;
                    }
#                   print "i is $i\n";
                    $i += 1; #to not include delete index
                    while ($i <= $#input) {
                        if ($input[$i] =~ /$end/) {
                            last;
                        }
                        $i++;
                    }
#                   print "i is $i\n";
                    $i += 1; #to not include delete index

                    while ($i <= $#input) {
                        print $input[$i], "\n";
                        $i++;
                    }

                }

				if ($s_slash == 1 && $e_slash == 1) {
					$start =~ s/\///g;
					$end =~ s/\///g;
					$i = 0;
					while ($i <= $#input) {
						if ($input[$i] =~ /$start/) {
							$i++;
							while (1) {
								if ($input[$i] =~ /$end/ || $i >= $#input) {
									last;
								}
								$i++;
							}
							$i++;
						}
						else {
							print "$input[$i] \n";
							$i++;
						}	
					}
				}
		}
		else {
			$target = $limit - 1;
			foreach $line (@input) {
			    if ($line ne $input[$target]) {
					print $line, "\n";
				}
			}
		}
    }
    else { #limit start with not number
        foreach $line (@input) {
            if ($line !~ $limit) {
                print $line, "\n";
            }
        }
	}
}


if ($real_option eq "s") {
	$s = $ARGV[0];
#	print "s is $s\n";

	if ($s =~ /g/) {
		$g_option = "g";
	}
#    $s =~ /(\w{1})\/(\[*)(\w*)\]*\/(\w*)\/(\w*)/;

#$s =~ /(\w{1}).{1}(\[*)(\w*)\]*.{1}(.*).{1}(\w*)/;i

$s =~ /(s).{1}(\[*)(\w*)\]*.{1}(.*).{1}(g*)/;

#s/11/zzz/g
    $bracket = $2;
    $target = $3;
    $substitute =$4;
#print "sub is $substitute\n";
#sX[15]XzzzX
#	print "Hi I am substitute\n";

#  print "target is $target\n";
# print "sub is $substitute\n";
#	print "first_letter is $f_letter\n";
#    $g_option = $5;
	
# print "g_option is $g_option\n";

	if ($g_option eq 'g') { #g_option exists
		$s = $ARGV[0];
		$s =~ /(s).{1}(\[*)(\w*)\]*.{1}(.*).{1}(g)/;
		$bracket = $2;
		$target = $3;
		$substitute = $4;

		if ($substitute ne "") { #substitute exists
			if ($bracket eq "[") { #bracket exists
				foreach $line (@input) {
					$line =~ s/[$target]/$substitute/g;
					print $line, "\n";
				}
			}
			else { #no bracket
				if ($f_letter =~ /\d/) { #select line_number to substitute
#					print "hey\n";
					$f_letter = substr($ARGV[0],0,1);
					if ($f_letter =~ /\//) {
#						/1.1/s/1/-/
						$command = $ARGV[0];
#						/1.1/s/1/-/g
						$command =~ /\/(.*)\/s\/(.*)\/(.*)\/g/;
						$line_number = $1;
						$target = $2;
						$substitute = $3;
#						print "line number is $line_number and target is $target and substitute is $substitute\n";
						foreach $line (@input) {
							if ($line =~ /$line_number/) {
								$line =~ s/$target/$substitute/g;
							}
							print $line, "\n"
						}

					}
					else { #select integer line number
						$command = $ARGV[0];
						$command =~ /(\d*)(\w{1})\/(\w*)\/(\w*)\//;
						$line_number = $1;
						$target = $3;
						$substitute =$4;
#						print "line number is $line_number target is $target substitute is $substitute\n";
						$index = $line_number - 1;
						foreach $line (@input) {
							if ($line eq $input[$index]) {
								$line =~ s/$target/$substitute/g;
							}
							print $line, "\n";
						}
					}

				}
				else { #substitute all lines
					foreach $line (@input) {
						$line =~ s/$target/$substitute/g;
						print $line, "\n";
					}
				}
			}
		}
		else { # no substitute
			if ($bracket eq "[") {
				foreach $line ($input) {
					$line =~ s/[$target]//g;
					print $line, "\n";
				}
			}
			else { #no bracket
	foreach $line (@input) {
					$line =~ s/$target//g;
					print $line, "\n";
				}
			}
		}
	}

	else { #not g_option
		if ($substitute ne "") { #substitute exists
			if ($bracket eq "[") {
#				print "I am here\n";
				foreach $line (@input) {
					$line =~ s/[$target]/$substitute/;
					print $line, "\n";
				}
			}
			else { #no bracket
				if ($f_letter =~ /\d/) { #select line_number to substitute
					$command = $ARGV[0];
#			print "Command is $command\n";
					$command =~ /(\d*)(\w{1})\/(\w*)\/(\w*)\//;
					$line_number = $1;
					$target = $3;
					$substitute =$4;
#					print "line number is $line_number target is $target substitute is $substitute\n";
					$index = $line_number - 1;

					foreach $line (@input) {
						if ($line eq $input[$index]) {
							$line =~ s/$target/$substitute/;
						}
						print $line, "\n";
					}
					
				}
				else {
					foreach $line (@input) { #substitute all line
						$line =~ s/$target/$substitute/;
						print $line, "\n";
					}
				}
			}
		}
		else { #no substitute
			if ($bracket eq "[") {
				foreach $line (@input) {
					$line =~ s/[$target]//;
					print $line, "\n";
				}
			}
			else {
					foreach $line (@input) {
						$line =~ s/$target//;
						print $line, "\n";
					}
			}
		}
	}
}


=cut
sub address {
	@input = shift;
	$start = shift;
	$end = shift;
 while ($i <= $#input) {
                         if ($input[$i] =~ /$start/) {
                             $i++;
                             while (1) {
                                 if ($input[$i] =~ /$end/ || $i >= $#input) {
                                     last;
                                 }
                                 $i++;
                             }
                             $i++;
                         }
                         else {
                             print "$input[$i] \n";
                             $i++;
                         }
                     }
}
