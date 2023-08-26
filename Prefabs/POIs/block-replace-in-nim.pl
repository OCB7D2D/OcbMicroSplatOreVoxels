use strict;
use warnings;

open(my $fh, "<", "deco_gold_vein.blocks.nim");

die "error $!" unless (read($fh, my $buffer, 4));
die "header not correct" unless unpack("l", $buffer) == 1;

die "error $!" unless (read($fh, $buffer, 4));
my $nblocks = unpack("l", $buffer);

warn "Found ${nblocks} blocks\n";

my @blocks;

for(my $i = 0; $i < $nblocks; $i++)
{
    die "error $!" unless (read($fh, $buffer, 4));
    my $id = unpack("l", $buffer);
    die "error $!" unless (read($fh, $buffer, 1));
    my $len = unpack("C", $buffer);
    die "error $!" unless (read($fh, my $name, $len));
    warn "  id ${id} => ${name}\n";
    push @blocks, [$id, $name];
}

# die "error $!" unless (read($fh, $buffer, 1));
# warn unpack("C", $buffer), "\n";
# die "error $!" unless (read($fh, $buffer, 1));
# warn unpack("C", $buffer), "\n";
# die "error $!" unless (read($fh, $buffer, 1));
# warn unpack("C", $buffer), "\n";
# die "error $!" unless (read($fh, $buffer, 15));
# warn "EOF ", eof($fh), "\n";

open(my $ofh, ">", "deco_gold_vein.blocks.new.nim")
    or die "Could not open new file with write access";

$ofh->print(pack("l", 1));
$ofh->print(pack("l", $nblocks));

foreach my $block (@blocks)
{
    $block->[1] = "terrOreStoneGoldRandom"
        if $block->[1] eq "terrOreStoneOilRandom";
    $block->[1] = "oreGoldBoulder"
        if $block->[1] eq "oreShaleBoulder";
    $block->[1] = "terrOreGold"
        if $block->[1] eq "terrOreGoldDeposit";

    $ofh->print(pack("l", $block->[0]));
    $ofh->print(pack("C", length($block->[1])));
    $ofh->print($block->[1]);
}