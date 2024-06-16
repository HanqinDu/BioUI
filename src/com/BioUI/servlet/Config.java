package com.BioUI.servlet;

public class Config {
	
	// the server require the following programs (accessible from system path)
	// rename, mailutils, tar, sysstat
	
	public static final String UPLOAD_DIR  = "/home/duhq/BioUI_workspace";
	public static final String RESULT_DIR  = "/home/duhq/tomcat/webapps/BioUI/Result";
	public static final String LOG_PATH    = "/home/duhq/tomcat/logs/catalina.out";
	public static final String SERVER_IP   = "172.16.20.20";
	public static final String SERVER_PORT = "8080"; //this config should be consist with the tomcat setting
	public static final String RESULT_URL  = SERVER_IP + ":" + SERVER_PORT + "/BioUI/Result";
	
	public static final int    EMAIL_RESEND_TIMES = 3;
	public static final int    EMAIL_RESEND_DELAY = 30;
	public static final String CACHE_LIFE = "+10080"; // mins
	public static final long   CLEAR_PERI = 1440; // mins
	
	// one line bash script: echo "$3" | mail -s "$2" "$1"
	public static final String MAIL_SH = "/home/duhq/BioUI_script/send_mail.sh"; 
	
	// one line bash script: find "$1" -mindepth 1 -maxdepth 1 -mmin "$2" -exec rm -rf {} \;
	public static final String CLEAR_SH = "/home/duhq/BioUI_script/clear_cache.sh"; 
	
	// echo '' > $1
	public static final String RELOG_SH = "/home/duhq/BioUI_script/empty_log.sh";
	
	// mpstat | sed "s/  */<\/td><td>/g"
	public static final String CPUSTAT_SH = "/home/duhq/BioUI_script/getCpuState.sh";
	
	public static final String SHARELINK_PATH = "/home/duhq/BioUI_script/share_link";	
	
	
	/**
	 *  application configuration
	 */
	
	public static final String USEARCH_PATH  = "/home/duhq/BioUI_script/usearch";

	public static final String CHECKML_SH    = "/home/duhq/BioUI_script/checkM_lineage_wf.sh";
	public static final String CHECKMLG_SH   = "/home/duhq/BioUI_script/checkM_lineage_wf_gene.sh";
	public static final String CHECKM_OUT    = "/home/duhq/BioUI_script/checkM_reform.out";

	public static final String GTDBTKC_SH    = "/home/duhq/BioUI_script/gtdbtk_classify_wf.sh";

	public static final String PRODIGAL_SH   = "/home/duhq/BioUI_script/prodigal.sh";

	public static final String BARNNAP_SH    = "/home/duhq/BioUI_script/barnnap.sh";

	public static final String EMAPPER_SH    = "/home/duhq/BioUI_script/eggnog_mapper.sh";

	public static final String tRNAscanSE_SH = "/home/duhq/BioUI_script/tRNAscanSE.sh";

	public static final String FASTANI_SH    = "/home/duhq/BioUI_script/fastANI.sh";

	public static final String MOTHUR_SH     = "/home/duhq/BioUI_script/mothur.sh";

	public static final String UBCG_SH       = "/home/duhq/BioUI_script/ubcg.sh";
	public static final String UBCG_PATH     = "/home/duhq/BioUI_script/UBCG";
	public static final String UBCGPLOT_SH   = "/home/duhq/BioUI_script/ubcg_plot_nwk.sh";

	public static final String SPADES_SH     = "/home/duhq/BioUI_script/spades.sh";
	public static final String SPADES_INFO_C = "/home/duhq/BioUI_script/spades_extract_contig_info";
	public static final String SPADES_PLOT_R = "/home/duhq/BioUI_script/spades_plot_len_cov.R";

	public static final String SPADES_FILTER = "/home/duhq/BioUI_script/spades_filter_cov_len";

	public static final String BLASTNJZZ_SH  = "/home/duhq/BioUI_script/blastnJzz.sh";
	public static final String BLASTNDB_SH   = "/home/duhq/BioUI_script/blastndb.sh";
	public static final String JZZNDB_PATH   = "/home/duhq/Database/jzzdb/jzzdb";
	public static final String BLASTPJZZ_SH  = "/home/duhq/BioUI_script/blastpJzz.sh";
	public static final String BLASTPDB_SH   = "/home/duhq/BioUI_script/blastpdb.sh";
	public static final String JZZPDB_PATH   = "/home/duhq/Database/jzzdb_protein/jzzdb_protein";
	public static final String GREENLAB_PATH = "/home/duhq/Database/green_lab_marker/green_lab_marker";
	public static final String GREENLAB_MAP  = "/home/duhq/Database/green_lab_marker/ID_filename_map.csv";
	public static final String ADDCSVHEAD_SH = "/home/duhq/BioUI_script/add_csv_head.sh";
	public static final String ADDTYPE_SH    = "/home/duhq/BioUI_script/add_greenlab_type.sh";
	public static final String ADDTYPE_R     = "/home/duhq/BioUI_script/add_greenlab_type.R";

	public static final String MAFFT_SH      = "/home/duhq/BioUI_script/mafft.sh";

	public static final String IQTREE_SH     = "/home/duhq/BioUI_script/iqtree.sh";

	public static final String EZAAI_SH      = "/home/duhq/BioUI_script/ezaai.sh";
	public static final String EZAAI_PATH    = "/home/duhq/BioUI_script/EzAAI.jar";
	
	public static final String POCP_SH       = "/home/duhq/BioUI_script/POCP.sh";
	public static final String ADDID_PATH    = "/home/duhq/BioUI_script/POCP_addid.out";
	public static final String POCP_PATH     = "/home/duhq/BioUI_script/POCP_calculate.R";
	
	public static final String CONCAT_SH     = "/home/duhq/BioUI_script/concat.sh";
	public static final String SPLIT_SH      = "/home/duhq/BioUI_script/split_fasta.sh";
	public static final String SPLIT_OUT     = "/home/duhq/BioUI_script/split_fasta.out";

	public static final String COMPAREM_SH   = "/home/duhq/BioUI_script/comparem.sh";
	
	public static final String UPGMA_SH      = "/home/duhq/BioUI_script/upgma.sh";

	public static final String MEGAHIT_SH    = "/home/duhq/BioUI_script/megahit.sh";

	public static final String PROKKA_SH     = "/home/duhq/BioUI_script/prokka.sh";

	public static final String QUAST_SH      = "/home/duhq/BioUI_script/quast.sh";
	
	public static final String REFLECT_SH    = "/home/duhq/BioUI_script/reflect_matrix.sh";

	public static final String KOFAMSCAN_SH  = "/home/duhq/BioUI_script/kofamscan.sh";
	public static final String KOFAMHMM_PATH = "/home/duhq/Database/kofam/profiles";
	public static final String KOLIST_PATH   = "/home/duhq/Database/kofam/ko_list";
	
	public static final String TANI_SH       = "/home/duhq/BioUI_script/tANI.sh";
	public static final String TANI_PERL     = "/home/duhq/BioUI_script/tANI_low_mem.pl";
	public static final String TANITREE_R    = "/home/duhq/BioUI_script/tANI_buildtree.R";

	public static final String MAXBIN_SH     = "/home/duhq/BioUI_script/maxbin2.sh";

	public static final String SIGNSTAT_SH   = "/home/duhq/BioUI_script/sign_record.sh";
	public static final String SIGNSTAT_R    = "/home/duhq/BioUI_script/sign_record.R";

	public static final String QIIME_IMPORT_SH    = "/home/duhq/BioUI_script/qiime_import.sh";
	public static final String QIIME_IMPORT_R     = "/home/duhq/BioUI_script/qiime_manifest_modify.R";
	public static final String QIIME_QC_PAIR_SH   = "/home/duhq/BioUI_script/qiime_qc_pair.sh";
	public static final String QIIME_QC_SINGLE_SH = "/home/duhq/BioUI_script/qiime_qc_pair.sh";
	public static final String QIIME_CLUSTER_SH   = "/home/duhq/BioUI_script/qiime_cluster.sh";
	public static final String QIIME_PHYLOGENY_SH = "/home/duhq/BioUI_script/qiime_phylogeny.sh";
	public static final String QIIME_DIVERSITY_SH = "/home/duhq/BioUI_script/qiime_diversity.sh";
	public static final String QIIME_TAXONOMY_SH  = "/home/duhq/BioUI_script/qiime_taxonomy.sh";
	public static final String QIIME_CLAS_GG_FULL = "/home/duhq/Database/qiime_classifier/gg-13-8-99-nb-classifier.qza";
	public static final String QIIME_CLAS_GG_CURT = "/home/duhq/Database/qiime_classifier/gg-13-8-99-515-806-nb-classifier.qza";
	public static final String QIIME_CLAS_SI_FULL = "/home/duhq/Database/qiime_classifier/silva-138-99-nb-classifier.qza";
	public static final String QIIME_CLAS_SI_CURT = "/home/duhq/Database/qiime_classifier/silva-138-99-515-806-nb-classifier.qza";

	public static final String ABI2SEQ_SH         = "/home/duhq/BioUI_script/abi2seq.sh";
	public static final String ABI2FASTQ_PY       = "/home/duhq/BioUI_script/abi2fastq.py";
	public static final String TRIM_FASTQ_R       = "/home/duhq/BioUI_script/trim_fastq.R";

	public static final String ANTISMASH_IMAGE_ID = "edcb380dcfdc";
	public static final String ANTISMASH_SCRIPT   = "/home/duhq/BioUI_script/antismash.sh";
	public static final String ANTISMASH_DOCKER   = "/home/duhq/BioUI_script/antismash_docker.sh";
}
