<?php
include_once "includes/config.php";
$database = new Config();
$db = $database->getConnection();

include_once 'includes/menu.inc.php';
$pro = new Menu($db);
$id = isset($_GET['id']) ? $_GET['id'] : die('ERROR: missing ID.');
$pro->id = $id;
	
if($pro->delete()){
	echo "<script>location.href='menu.php';</script>";
} else{
	echo "<script>alert('Gagal Hapus Data');location.href='menu.php';</script>";
		
}
?>
