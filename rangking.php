<?php
include_once 'header.php';
include_once 'includes/menu.inc.php';
$pro1 = new Menu($db);
$stmt1 = $pro1->readAll();
include_once 'includes/kriteria.inc.php';
$pro2 = new Kriteria($db);
$stmt2 = $pro2->readAll();
include_once 'includes/rangking.inc.php';
$pro = new Rangking($db);
$stmt = $pro->readKhusus();
$count = $pro->countAll();

if(isset($_POST['hapus-contengan'])){
    $imp = "('".implode("','",array_values($_POST['checkbox']))."')";
    $result = $pro->hapusell($imp);
    if($result){
            ?>
            <script type="text/javascript">
            window.onload=function(){
                showSuccessToast();
                setTimeout(function(){
                    window.location.reload(1);
                    history.go(0)
                    location.href = location.href
                }, 5000);
            };
            </script>
            <?php
    } else{
            ?>
            <script type="text/javascript">
            window.onload=function(){
                showErrorToast();
                setTimeout(function(){
                    window.location.reload(1);
                    history.go(0)
                    location.href = location.href
                }, 5000);
            };
            </script>
            <?php
    }
}
?>
	<br/>
	<div>
	
	  <!-- Nav tabs -->
	  <ul class="nav nav-tabs" role="tablist">
	    <li role="presentation" class="active"><a href="#lihat" aria-controls="lihat" role="tab" data-toggle="tab">Lihat Semua Data</a></li>
	    <li role="presentation"><a href="#rangking" aria-controls="rangking" role="tab" data-toggle="tab">Perangkingan</a></li>
	    <li role="presentation"><a href="rangking-baru.php" role="tab">Tambah Data</a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div role="tabpanel" class="tab-pane active" id="lihat">
	    	<br/>
	    	<form method="post">
			<div class="row">
				<div class="col-md-6 text-left">
					<h4>Data Rangking</h4>
				</div>
				<div class="col-md-6 text-right">
		            <button type="button" onclick="location.href='rangking-baru.php'" class="btn btn-primary">Tambah Data</button>
				</div>
			</div>
			<br/>
			<table width="100%" class="table table-striped table-bordered" id="tabeldata">
		        <thead>
		            <tr>
		                <th>Menu</th>
		                <th>Kriteria</th>
		                <th>Nilai</th>
		                <th width="100px">Aksi</th>
		            </tr>
		        </thead>
		
		        <tfoot>
		            <tr>
		                <th>Menu</th>
		                <th>Kriteria</th>
		                <th>Nilai</th>
		                <th>Aksi</th>
		            </tr>
		        </tfoot>
		
		        <tbody>
		<?php
		$no=1;
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
		?>
		            <tr>
		                <td style="vertical-align:middle;"><?php echo $row['nama_menu'] ?></td>
		                <td style="vertical-align:middle;"><?php echo $row['nama_kriteria'] ?></td>
		                <td style="vertical-align:middle;"><?php echo $row['nilai_rangking'] ?></td>
		                <td class="text-center" style="vertical-align:middle;">
							<a href="rangking-ubah.php?ia=<?php echo $row['id_menu'] ?>&ik=<?php echo $row['id_kriteria'] ?>" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
							<a href="rangking-hapus.php?ia=<?php echo $row['id_menu'] ?>&ik=<?php echo $row['id_kriteria'] ?>" onclick="return confirm('Yakin ingin menghapus data')" class="btn btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
					    </td>
		            </tr>
		<?php
		}
		?>
		        </tbody>
		
		    </table>
		    	</form>	
	    </div>

	    <div role="tabpanel" class="tab-pane" id="rangking">
	    	<br/>
	    	<h4>Perangkingan</h4>
			<table width="100%" class="table table-striped table-bordered">
		        <thead>
		            <tr>
		                <th rowspan="2" style="vertical-align: middle" class="text-center">Menu</th>
		                <th colspan="<?php echo $stmt2->rowCount(); ?>" class="text-center">Kriteria</th>
		                <th rowspan="2" style="vertical-align: middle" class="text-center">Vektor S</th>
		                <th rowspan="2" style="vertical-align: middle" class="text-center">Vektor V</th>
		            </tr>
		            <tr>
		            <?php
					while ($row2 = $stmt2->fetch(PDO::FETCH_ASSOC)){
					?>
		                <th><?php echo $row2['nama_kriteria'] ?></th>
		            <?php
					}
					?>
		            </tr>
		        </thead>
		
		        <tbody>
		<?php
		while ($row1 = $stmt1->fetch(PDO::FETCH_ASSOC)){
		?>
		            <tr>
		                <th><?php echo $row1['nama_menu'] ?></th>
		                <?php
		                $a= $row1['id_menu'];
						$stmtr = $pro->readR($a);
						while ($rowr = $stmtr->fetch(PDO::FETCH_ASSOC)){
							$b = $rowr['id_kriteria'];
							$tipe = $rowr['tipe_kriteria'];
							$bobot = $rowr['hasil_bobot'];
						?>
		                <td>
		                	<?php 
		                	if($tipe=='benefit'){
		                		echo $nor = pow($rowr['nilai_rangking'],$bobot);
							} else{
								echo $nor = pow($rowr['nilai_rangking'],-$bobot);
							}

							$pro->ia = $a;
							$pro->ik = $b;
							$pro->nn4 = $nor;
							$pro->normalisasi1();
		                	?>
		                </td>
		                <?php
		                }
						?>
						<td>
							<?php 
							$stmthasil = $pro->readHasil1($a);
							$hasil = $stmthasil->fetch(PDO::FETCH_ASSOC);
							echo $hasil['bbn'];
							$pro->has1 = $hasil['bbn'];
							$pro->hasil1();
							?>
						</td>
						<td>
							<?php
							$stmtmax = $pro->readMax();
							$maxnr = $stmtmax->fetch(PDO::FETCH_ASSOC);
							echo $hasil['bbn']/$maxnr['mnr1'];
							$pro->has2 = $hasil['bbn']/$maxnr['mnr1'];
							$pro->hasil2();
							?>
						</td>
		            </tr>
		<?php
		}
		?>
		        </tbody>
		
		    </table>
		    	
	    </div>
	  </div>
	
	</div>
<?php
include_once 'footer.php';
?>