<?php
require('fpdf.php');
require("../../db_config.php");

class PDF extends FPDF
{

function WriteHTML($html)
{
    // HTML parser
    $html = str_replace("\n",' ',$html);
    $a = preg_split('/<(.*)>/U',$html,-1,PREG_SPLIT_DELIM_CAPTURE);
    foreach($a as $i=>$e)
    {
        if($i%2==0)
        {
            // Text
            if($this->HREF)
                $this->PutLink($this->HREF,$e);
            else
                $this->Write(5,$e);
        }
        else
        {
            // Tag
            if($e[0]=='/')
                $this->CloseTag(strtoupper(substr($e,1)));
            else
            {
                // Extract attributes
                $a2 = explode(' ',$e);
                $tag = strtoupper(array_shift($a2));
                $attr = array();
                foreach($a2 as $v)
                {
                    if(preg_match('/([^=]*)=["\']?([^"\']*)/',$v,$a3))
                        $attr[strtoupper($a3[1])] = $a3[2];
                }
                $this->OpenTag($tag,$attr);
            }
        }
    }
}

function OpenTag($tag, $attr)
{
    // Opening tag
    if($tag=='B' || $tag=='I' || $tag=='U')
        $this->SetStyle($tag,true);
    if($tag=='A')
        $this->HREF = $attr['HREF'];
    if($tag=='BR')
        $this->Ln(5);
}

function CloseTag($tag)
{
    // Closing tag
    if($tag=='B' || $tag=='I' || $tag=='U')
        $this->SetStyle($tag,false);
    if($tag=='A')
        $this->HREF = '';
}


// Page header
function Header()
{
	$jdlLaporan = $_POST['jdlLaporan'];
	$blnLaporan = $_POST['bulan'];
	$thnLaporan = $_POST['tahun'];
	$cetak = $_POST['tglCetak'];
	if($blnLaporan != "")
	{
		$periodeLaporan = $blnLaporan." ".$thnLaporan;
	} else
	{
		$periodeLaporan = $thnLaporan;
	}
    // Logo
    //$this->Image('logo.png',10,6,30);
    // Arial bold 15
    $this->SetFont('Arial','B',15);
    // Move to the right
    $this->Cell(150);
    // Title
    //$this->Cell(30,10,$jdlLaporan,0,0,'C');
	$this->Cell(30,10,'Laporan Sisa Angsuran Barang',0,0,'C');
	
	$this->Ln(3);
	
	$this->Cell(150);
	$this->Cell(30,20,'KOPERASI MULTIGUNA KECAMATAN PANEKAN',0,0,'C');
	$this->Cell(-30,35,"PERIODE : ".$periodeLaporan,0,0,'C');
	$this->Cell(300,5,"Cetak : ".$cetak,0,0,'C');

    // Line break
    $this->Ln(20);
}

// Page footer
function Footer()
{
    // Position at 1.5 cm from bottom
    $this->SetY(-15);
    // Arial italic 8
    $this->SetFont('Arial','I',8);
    // Page number
    $this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
	  //$this->Cell(0,5,'Panekan, '.$this->PageNo().'/{nb}',0,0,'C');
	}
	
}

//Create new pdf file
$pdf=new PDF('L','mm','Legal');;

//Open file
//$pdf->Open();

//$pdf->AliasNbPages();

//Disable automatic page break
$pdf->SetAutoPageBreak(false);

//Add first page
//$pdf->AddPage();

//$pdf = new PDF();
$pdf->AliasNbPages();
$pdf->AddPage();


$y_axis_initial = 40;
$row_height = 12;

//print column titles for the actual page
$pdf->SetFillColor(232, 232, 232);
$pdf->SetFont('Arial', 'B', 10);
$pdf->SetY($y_axis_initial);
$pdf->SetX(60);
//$a = $pdf->WriteHTML('Nomer<br>Simpanan');
$pdf->Cell(25, 12, 'NO.PINJAM', 1, 0, 'C', 1);
$pdf->Cell(20, 12, 'NPA', 1, 0, 'C', 1);
$pdf->Cell(50, 12, 'NAMA', 1, 0, 'C', 1);
$pdf->Cell(50, 12, 'INSTANSI', 1, 0, 'C', 1);
$pdf->Cell(40, 12, 'SISA ANGSURAN', 1, 0, 'C', 1);
$pdf->Cell(40, 12, 'SISA CICILAN', 1, 0, 'C', 1);

//Select the Products you want to show in your PDF file
$table = $_POST['nmTabel'];
$blnLaporan = $_POST['bulan'];
if($blnLaporan == 1){
		$blnLaporan = "Januari";
	}
	if($blnLaporan == 2){
		$blnLaporan = "Februari";
	}
	if($blnLaporan == 3){
		$blnLaporan = "Maret";
	}
	if($blnLaporan == 4){
		$blnLaporan = "April";
	}
	if($blnLaporan == 5){
		$blnLaporan = "Mei";
	}
	if($blnLaporan == 6){
		$blnLaporan = "Juni";
	}
	if($blnLaporan == 7){
		$blnLaporan = "Juli";
	}
	if($blnLaporan == 8){
		$blnLaporan = "Agustus";
	}
	if($blnLaporan == 9){
		$blnLaporan = "September";
	}
	if($blnLaporan == 10){
		$blnLaporan = "Oktober";
	}
	if($blnLaporan == 11){
		$blnLaporan = "November";
	}
	if($blnLaporan == 12){
		$blnLaporan = "Desember";
	}
$thnLaporan = $_POST['tahun'];
if($blnLaporan != "")
{
$result=mysql_query("select p.no_pinjam , p.npa, a.nama, a.instansi from ".$table." p, anggota a where month(tgl_pinjam) = '$blnLaporan' AND year(tgl) = '$thnLaporan' AND a.npa = p.npa ORDER BY p.no_pinjam");
}
else
{
//echo "select p.no_pinjam , p.npa, a.nama, a.instansi from ".$table." p, anggota a where year(tgl_pinjam) = '$thnLaporan' AND a.npa = p.npa ORDER BY no_pinjam";
$result=mysql_query("select p.no_pinjam , p.npa, a.nama, a.instansi from ".$table." p, anggota a where year(tgl_pinjam) = '$thnLaporan' AND a.npa = p.npa ORDER BY no_pinjam");
}
//initialize counter
$i = 0;

//Set maximum rows per page
$max = 25;

//Set Row Height
//$row_height = 6;

//$y_axis = 50;
$y_axis = $y_axis_initial + $row_height;
$jmlBaris = mysql_num_rows($result);
$brs = 1;
while($row = mysql_fetch_array($result))
{
	$row_height = 6;
    //If the current row is the last one, create new page and print column title
    if ($i == $max)
    {
        $pdf->AddPage();

        //print column titles for the current page
        $pdf->SetY($y_axis_initial);
        $pdf->SetX(60);
        $pdf->Cell(25, 12, 'NO.PINJAM', 1, 0, 'C', 1);
		$pdf->Cell(20, 12, 'NPA', 1, 0, 'C', 1);
		$pdf->Cell(50, 12, 'NAMA', 1, 0, 'C', 1);
		$pdf->Cell(50, 12, 'INSTANSI', 1, 0, 'C', 1);
		$pdf->Cell(40, 12, 'SISA ANGSURAN', 1, 0, 'C', 1);
		$pdf->Cell(40, 12, 'SISA CICILAN', 1, 0, 'C', 1);
				
        //Go to next row
		$y_axis_initial = 40;
		$row_height_ = 12;
        $y_axis = $y_axis_initial + $row_height_;
        
        //Set $i variable to 0 (first row)
        $i = 0;
    }
	
    $noPinjam = $row['no_pinjam'];
    $npa = $row['npa'];
	$nama = $row['nama'];
	$instansi = $row['instansi'];

				$qsisa = mysql_query("SELECT SUM(angsuran) AS tot_angsuran, count(angsuran) AS tot_cicilan FROM angsuran_barang where no_pinjam = '$noPinjam' and bayar = '0'")or die(mysql_error());
				$sisa = mysql_fetch_assoc($qsisa);
	
				if(($sisa['tot_angsuran']) == NULL)
				{
					$totAngsuran = "0";
				}
				else
				{
					$totAngsuran = $sisa['tot_angsuran'];
				}
				
				
				$totCicilan = $sisa['tot_cicilan']; 
		
	
    $pdf->SetY($y_axis);
    $pdf->SetX(60);
	$pdf->Cell(25, 6, $noPinjam, 1, 0, 'L', 1);
	$pdf->Cell(20, 6, $npa, 1, 0, 'L', 1);
	$pdf->Cell(50, 6, $nama, 1, 0, 'L', 1);
	$pdf->Cell(50, 6, $instansi, 1, 0, 'L', 1);
	$pdf->Cell(40, 6, $totAngsuran, 1, 0, 'L', 1);
	$pdf->Cell(40, 6, $totCicilan, 1, 0, 'L', 1);

    //Go to next row
    $y_axis = $y_axis + $row_height;
    $i = $i + 1;
	$brs = $brs + 1;
	
	if($brs > $jmlBaris)
	{
		if($y_axis > 140)
		{
			$pdf->AddPage();
			$y_axis = 40;
		}
		$cetak = $_POST['tglCetak'];
		$y_axis = $y_axis+5;
		$pdf->SetY($y_axis);
		$pdf->SetX(250);
		$pdf->Cell(30,10,"Panekan,".$cetak,0,0,'C');
		
		$y_axis = $y_axis+5;
		$pdf->SetY($y_axis);
		$pdf->SetX(250);
		$pdf->Cell(30,10,"Ptugas Toko",0,0,'C');
		$pdf->SetX(70);
		$pdf->Cell(30,10,"Ketua",0,0,'C');
		
		$str="select a.nama from pengurus p inner join anggota a on a.npa = p.npa AND p.jabatan='toko'";	
		$nm = mysql_query($str) or die(mysql_error());
		$nama = mysql_fetch_row($nm);
		
		$y_axis = $y_axis+25;
		$pdf->SetY($y_axis);
		$pdf->SetX(250);
		$pdf->Cell(30,10,$nama[0],0,0,'C');


		$str="select a.nama from pengurus p inner join anggota a on a.npa = p.npa AND p.jabatan='toko'";
		$nm = mysql_query($str) or die(mysql_error());
		$nama = mysql_fetch_row($nm);
		
		$y_axis = $y_axis+1;
		$pdf->SetY($y_axis);
		$pdf->SetX(70);
		$pdf->Cell(30,10,$nama[0],0,0,'C');
	}	
	
}
$pdf->Output();

?>