class VariantParser
  require 'yaml'
  require 'smarter_csv'
  require 'spreadsheet'
  require 'optimist'
  require 'ruby-progressbar'
  require 'digest/bubblebabble'
  require_relative 'variant'
  require_relative 'cnv'
  require_relative 'allele'
  require_relative 'variant_store'
  require_relative 'cnv_store'
  require_relative 'symbol_checker'
  
  
  def parse_alamut_file(file_name, sample_ids)
  	options = { :col_sep => "\t" }
  	variant_array = Array.new 
  	line_count = `wc -l #{file_name}`
  	if File.exists?(file_name) && ( File.stat(file_name).size > 0 )
  		progressbar = ProgressBar.create(:title => "Loading variants",:format => "%t %c : %C %w", :total => line_count.to_i)

  		SmarterCSV.process( file_name, options ) do |csv|
  			this_variant = Variant.new
  			if csv.first[:assembly] && csv.first[:assembly].match(/GRCh/i)
  				this_variant.uid													= Digest::SHA256.bubblebabble csv.first.flatten.join("|+|")
  				this_variant.id														= csv.first[:id]
  				this_variant.assembly											= csv.first[:assembly]
  				this_variant.chromosome 									= csv.first[:chrom]
  				this_variant.position											= csv.first[:inputpos]
  				this_variant.genomic_dna_start						= csv.first[:gdnastart]
  				this_variant.genomic_dna_end							= csv.first[:gdnaend]
  				this_variant.complementary_dna_start			= csv.first[:cdnastart]
  				this_variant.complementary_dna_end				= csv.first[:cdnaend]
  				this_variant.gene_id											= csv.first[:geneid]
  				this_variant.gene 												= csv.first[:gene]
  				this_variant.gene_description							= csv.first[:genedesc]
  				this_variant.full_transcript 							= csv.first[:transcript]
  				this_variant.transcript_length						= csv.first[:translen]
  				this_variant.var_type											= csv.first[:vartype]
  				this_variant.coding_effect								= csv.first[:codingeffect]
  				this_variant.var_location 								= csv.first[:varlocation]
  				this_variant.strand 											= csv.first[:strand]
  				this_variant.genomic_nomen 								= csv.first[:gnomen]
  				this_variant.cdna_nomen	 									= csv.first[:cnomen]
  				this_variant.protein_nomen 								= csv.first[:pnomen]
  				this_variant.protein											= csv.first[:protein]
  				this_variant.uniprot											= csv.first[:uniprot]
  				this_variant.alt_protein_nomen						= csv.first[:alt_pnomen]
  				this_variant.go_bio_process								= csv.first[:gobioprocess]
  				this_variant.go_cell_comp									= csv.first[:gocellcomp]
  				this_variant.go_mol_func									= csv.first[:gomolfunc]
  				this_variant.omim_id											= csv.first[:omimid]
  				this_variant.exon													= csv.first[:exon]
  				this_variant.intron												= csv.first[:intron]
  				this_variant.distance_nearest_splice_site = csv.first[:distnearestss]
  				this_variant.nearest_splice_site_type 		= csv.first[:nearestsstype]
  				this_variant.nearest_splice_site_change 	= csv.first[:nearestsschange]
  				this_variant.local_splice_effect					= csv.first[:localspliceeffect]
  				this_variant.local_ss_pos									= csv.first[:localss_pos]
  				this_variant.local_ss_wt_max_ent_score		= csv.first[:localss_wtmaxentscore]
  				this_variant.local_ss_wt_nns_score				= csv.first[:localss_wtnnsscore]
  				this_variant.local_ss_wt_hsf_score				= csv.first[:localss_wthsfscore]
  				this_variant.local_ss_var_max_ent_score		= csv.first[:localss_varmaxentscore]
  				this_variant.local_ss_var_nns_score				= csv.first[:localss_varnnsscore]
  				this_variant.local_ss_var_hsf_score				= csv.first[:localss_varhsfscore]
  				this_variant.wt_ssf_score									= csv.first[:wtssfscore]
  				this_variant.wt_max_ent_score							= csv.first[:wtmaxentscore]
  				this_variant.wt_nns_score									= csv.first[:wtnnsscore]
  				this_variant.wt_gs_score									= csv.first[:wtgsscore]
  				this_variant.wt_hsf_score									= csv.first[:wthsfscore]
  				this_variant.var_ssf_score								= csv.first[:varssfscore]
  				this_variant.var_max_ent_score						= csv.first[:varmaxentscore]
  				this_variant.var_nns_score								= csv.first[:varnnsscore]
  				this_variant.var_gs_score									= csv.first[:vargsscore]
  				this_variant.var_hsf_score								= csv.first[:varhsfscore]	
  				this_variant.branch_point_pos							= csv.first[:branchpointpos]
  				this_variant.branch_point_change					= csv.first[:branchpointchange]
  				this_variant.protein_domain_1							= csv.first[:proteindomain1]
  				this_variant.protein_domain_2							= csv.first[:proteindomain2]
  				this_variant.protein_domain_3							= csv.first[:proteindomain3]
  				this_variant.protein_domain_4							= csv.first[:proteindomain4]
  				this_variant.rs_id 												= csv.first[:rsid]
  				this_variant.rs_validated 								= csv.first[:rsvalidated]
  				this_variant.rs_suspect 									= csv.first[:rssuspect]
  				this_variant.rs_validations 							= csv.first[:rsvalidations]
  				this_variant.rs_validation_number					= csv.first[:rsvalidationnumber]
  				this_variant.rs_ancestral_allele					= csv.first[:rsancestralallele]
  				this_variant.rs_heterozygosity						= csv.first[:rsheterozygosity]
  				this_variant.rs_clinical_significance			= csv.first[:rsclinicalsignificance]
  				this_variant.rs_maf_allele								= csv.first[:rsmafallele]
  				this_variant.rs_maf												= csv.first[:rsmaf]
  				this_variant.rs_maf_count									= csv.first[:rsmafcount]
  				this_variant.genomes_1000_freq						= csv.first[:"1000g_af"]
  				this_variant.genomes_1000_afr_freq				= csv.first[:"1000g_afr_af"]
  				this_variant.genomes_1000_sas_freq  			= csv.first[:"1000g_sas_af"]
  				this_variant.genomes_1000_eas_freq  			= csv.first[:"1000g_eas_af"]
  				this_variant.genomes_1000_eur_freq  			= csv.first[:"1000g_eur_af"]
  				this_variant.genomes_1000_amr_freq  			= csv.first[:"1000g_amr_af"]
  				this_variant.gnomad_all_freq              			= csv.first[:gnomadaltfreq_all]
  				this_variant.gnomad_afr_freq              			= csv.first[:gnomadaltfreq_afr]
  				this_variant.gnomad_amr_freq              			= csv.first[:gnomadaltfreq_amr]
  				this_variant.gnomad_eas_freq              			= csv.first[:gnomadaltfreq_eas]
  				this_variant.gnomad_sas_freq              			= csv.first[:gnomadaltfreq_sas]
  				this_variant.gnomad_nfe_freq              			= csv.first[:gnomadaltfreq_nfe]
  				this_variant.gnomad_fin_freq              			= csv.first[:gnomadaltfreq_fin]
  				this_variant.gnomad_oth_freq              			= csv.first[:gnomadaltfreq_oth]
  				this_variant.gnomad_afr_hmz              			= csv.first[:gnomadhomfreq_afr]
  				this_variant.gnomad_amr_hmz              			= csv.first[:gnomadhomfreq_amr]
  				this_variant.gnomad_eas_hmz              			= csv.first[:gnomadhomfreq_eas]
  				this_variant.gnomad_sas_hmz             			= csv.first[:gnomadhomfreq_sas]
  				this_variant.gnomad_nfe_hmz              			= csv.first[:gnomadhomfreq_nfe]
  				this_variant.gnomad_fin_hmz              			= csv.first[:gnomadhomfreq_fin]
  				this_variant.gnomad_oth_hmz              			= csv.first[:gnomadhomfreq_oth]
  				this_variant.gnomad_filter         	  	 		= csv.first[:gnomadfilter]
  				this_variant.gnomad_read_depth        	 			= csv.first[:gnomadreaddepth]
          this_variant.gnomad_het_count                = csv.first[:gnomadhetcount_all]
          this_variant.gnomad_hom_count                = csv.first[:gnomadhomcount_all]
          this_variant.gnomad_hem_count                = csv.first[:gnomadhemcount_all]
  				this_variant.clin_var_ids           			= csv.first[:clinvarids]
  				this_variant.clin_var_origins    	  			= csv.first[:clinvarorigins]
  				this_variant.clin_var_methods    	 	 			= csv.first[:clinvarmethods]
  				this_variant.clin_var_clin_signifs				= csv.first[:clinvarclinsignifs]
  				this_variant.clin_var_review_status				= csv.first[:clinvarreviewstatus]
  				this_variant.clin_var_phenotypes	  			= csv.first[:clinvarphenotypes]
  				this_variant.cosmic_ids         	  			= csv.first[:cosmicids]
  				this_variant.cosmic_tissues      	  			= csv.first[:cosmictissues]
  				this_variant.cosmic_freqs           			= csv.first[:cosmicfreqs]
  				this_variant.cosmic_sample_counts	  			= csv.first[:cosmicsamplecounts]
  				this_variant.esp_all_maf									= csv.first[:espallmaf]
					this_variant.esp_ref_ea_count  						= csv.first[:esprefeacount]
					this_variant.esp_ref_aa_count  						= csv.first[:esprefaacount]
					this_variant.esp_ref_all_count 						= csv.first[:esprefallcount]
					this_variant.esp_alt_ea_count  						= csv.first[:espalteacount]
					this_variant.esp_alt_aa_count  						= csv.first[:espaltaacount]
					this_variant.esp_alt_all_count 						= csv.first[:espaltallcount]
					this_variant.esp_ea_maf       						= csv.first[:espeamaf]
					this_variant.esp_aa_maf       						= csv.first[:espaamaf]
					this_variant.esp_ea_aaf       						= csv.first[:espeaaaf]
					this_variant.esp_aa_aaf       						= csv.first[:espaaaaf]
					this_variant.esp_all_aaf      						= csv.first[:espallaaf]
					this_variant.esp_avg_read_depth						= csv.first[:espavgreaddepth]
					this_variant.cosmic_ids										= csv.first[:cosmicids]
					this_variant.cosmic_tissues								= csv.first[:cosmictissues]
					this_variant.cosmic_freqs       					= csv.first[:cosmicfreqs]
					this_variant.cosmic_sample_counts					= csv.first[:cosmicsamplecounts]
					                                        	
					this_variant.subst_type										= csv.first[:substtype]
					this_variant.nuc_change   								= csv.first[:nucchange]
					this_variant.phast_cons   								= csv.first[:phastcons]
					this_variant.phylo_p      								= csv.first[:phylop]
					this_variant.wt_aa_1      								= csv.first[:wtaa_1]
					this_variant.wt_aa_3      								= csv.first[:wtaa_3]
					this_variant.wt_codon     								= csv.first[:wtcodon]
					this_variant.wt_codon_freq 								= csv.first[:wtcodonfreq]
					this_variant.var_aa_1     								= csv.first[:varaa_1]
					this_variant.var_aa_3     								= csv.first[:varaa_3]
					this_variant.var_codon    								= csv.first[:varcodon]
					this_variant.var_codon_freq								= csv.first[:varcodonfreq]
					this_variant.pos_aa       								= csv.first[:posaa]
					                                        	
					this_variant.blosum_45          					= csv.first[:blosum45]
					this_variant.blosum_62          					= csv.first[:blosum62]
					this_variant.blosum_80          					= csv.first[:blosum80]
					this_variant.wt_aa_composition   					= csv.first[:wtaacomposition]
					this_variant.var_aa_composition  					= csv.first[:varaacomposition]
					this_variant.wt_aa_polarity      					= csv.first[:wtaapolarity]
					this_variant.var_aa_polarity     					= csv.first[:varaapolarity]
					this_variant.wt_aa_volume        					= csv.first[:wtaavolume]
					this_variant.var_aa_volume       					= csv.first[:varaavolume]
			  	                                        	
			  	                                        	
  				this_variant.hgmd_phenotype 							= csv.first[:hgmdphenotype]
  				this_variant.hgmd_pub_med_id 							= csv.first[:hgmdpubmedid]
  				this_variant.hgmd_sub_category 						= csv.first[:hgmdsubcategory]
  				this_variant.n_orthos											= csv.first[:northos]
  				this_variant.conserved_orthos							= csv.first[:conservedorthos]
  				this_variant.conserved_dist_species				= csv.first[:conserveddistspecies]
  				this_variant.grantham_dist								= csv.first[:granthamdist]
  				this_variant.agv_gd_gv										= csv.first[:agvgdgv]
  				this_variant.agv_gd_gd										= csv.first[:agvgdgd]	
  				this_variant.agv_gd_class									= csv.first[:agvgdclass]
  				                                        	
  				this_variant.sift_prediction							= csv.first[:siftprediction]
  				this_variant.sift_weight									= csv.first[:siftweight]
  				this_variant.sift_median									= csv.first[:siftmedian]
  				this_variant.mapp_prediction  						= csv.first[:mappprediction]
  				this_variant.mapp_p_value      						= csv.first[:mapppvalue]
  				this_variant.mapp_p_value_median					= csv.first[:mapppvaluemedian]
  				                                        	
  				this_variant.wt_nuc												= csv.first[:wtnuc]
  				this_variant.var_nuc											= csv.first[:varnuc]
  				this_variant.ins_nucs											= csv.first[:insnucs]
  				this_variant.del_nucs											= csv.first[:delnucs]
  				                                        	
  				this_variant.quality_vcf									= csv.first[:"quality_(vcf)"]
  				this_variant.filter_vcf										= csv.first[:"filter_(vcf)"]
  				this_variant.ac 													= csv.first[:ac]
  				this_variant.af 													= csv.first[:af]
  				this_variant.an 													= csv.first[:an]
  				this_variant.dp 													= csv.first[:dp]
  				this_variant.fs 													= csv.first[:fs]
  				this_variant.mq 													= csv.first[:mq]
  				this_variant.mq_0													= csv.first[:mq0]
  				this_variant.qd 													= csv.first[:qd]
        	
  				sample_ids.each do |sample_id|
  					sample_id_lc = sample_id.downcase.gsub(/-/,'_')
  					this_allele = Allele.new
  					
  					this_allele.ad											= csv.first[:"ad_(#{sample_id_lc})"]
  					this_allele.dp											= csv.first[:"dp_(#{sample_id_lc})"]
  					this_allele.gq											= csv.first[:"gq_(#{sample_id_lc})"]
  					this_allele.gt											= csv.first[:"gt_(#{sample_id_lc})"]
  					this_allele.pl											= csv.first[:"pl_(#{sample_id_lc})"]
  					this_variant.alleles.store("#{sample_id}", this_allele)
  				end
  				
  				this_variant.parse_transcript()
  				variant_array.push(this_variant)
  				progressbar.increment
  			else
  				
  			end
  		end
  	else
  		puts "ERROR :: variants file has no content :: SAMPLE ID : #{ex_number_lc}"
  		if File.exists?(file_name)
  			puts "File exists? #{File.exists?(file_name)}"
  			puts "File size? #{File.stat(file_name).size}"
  		else
  			puts "File exists? #{File.exists?(file_name)}"
  		end
  	end
  	return variant_array
  end
  
  def parse_cnv_file(file_name, sample_ids)
  	options = { :col_sep => "\t" }
  	cnv_array = Array.new 
  	
  	if File.exists?(file_name) && ( File.stat(file_name).size > 0 )

  		SmarterCSV.process( file_name, options ) do |csv|
 
  			this_cnv = Cnv.new
  			this_cnv.chrom					= csv.first[:chrom]
  			this_cnv.pos						= csv.first[:pos]
  			this_cnv.gene           = csv.first[:gene]
  			this_cnv.transcript     = csv.first[:transcript]
  			this_cnv.type           = csv.first[:type]
  			this_cnv.var_type       = csv.first[:vartype]
  			this_cnv.g_dna_start    = csv.first[:gdnastart]
  			this_cnv.g_dna_end      = csv.first[:gdnaend]
  			this_cnv.g_nomen        = csv.first[:gnomen]
  			this_cnv.exon           = csv.first[:exon]
  			this_cnv.allele_freq    = csv.first[:allelefreq]
  			this_cnv.filter         = csv.first[:"filter_(vcf)"]
  			
  			sample_ids.each do |sample_id|
  				sample_id_lc = sample_id.downcase.gsub(/-/,'_')
  				this_allele = Allele.new  				
  				this_allele.ad											= csv.first[:"ad_(#{sample_id_lc})"]
  				this_allele.dp											= csv.first[:"dp_(#{sample_id_lc})"]
  				this_allele.gq											= csv.first[:"gq_(#{sample_id_lc})"]
  				this_allele.gt											= csv.first[:"gt_(#{sample_id_lc})"]
  				this_allele.bf											= csv.first[:"bf_(#{sample_id_lc})"]

  				this_cnv.alleles.store("#{sample_id}", this_allele)
  			end
  			
  			cnv_array.push(this_cnv)
  		end
  	else
  		puts "ERROR :: CNV file has no content"
  		if File.exists?(file_name)
  			puts "File exists? #{File.exists?(file_name)}"
  			puts "File size? #{File.stat(file_name).size}"
  		else
  			puts "File exists? #{File.exists?(file_name)}"
  		end
  	end
  	return cnv_array
  end 
  
  def parse_sample_ids(this_filepath)
  	
  	header = File.foreach(this_filepath).first
  	header_array = header.split(/\t/)
  	genotype_fields = header_array.select{ |e| e=~/GT/ }
  	sample_ids = genotype_fields.collect{ |e| e.gsub(/GT |\(|\)/, '') }
  	sample_ids.map{|id| id.downcase!}
  	return sample_ids
  end

  def parse_gene_list(genes_filepath)
  
  	  gene_symbol_list = Array.new
  	  File.foreach(genes_filepath) do |line|
  	  	  gene_symbol_list.push(line.strip)
  	  end
  	  return gene_symbol_list
  end

  def parse_hpo_gene_list(hpo_genes_filepath)	
  	  gene_id_list = Array.new
  	  File.foreach(hpo_genes_filepath) do |line|
  	  	  if !( line.match('Export for') || line.match('Associated diseases') || line.match('Total') )
  	  	  	  gene_symbol = line.split('","').first.delete('"').split(' ').first
  	  	  	  hgnc_id = line.split('","').first.delete('"').split(' ')[1].delete('(').delete(')')
  	  	  	  gene_id_list.push(hgnc_id)
  	  	  end
  	  end
  	  gene_id_list.sort!
  	  return gene_id_list
  end

  def variants_to_excel(results, workbook)
  	  this_sheet = workbook.create_worksheet :name => "Selected variants"
  	  row_number = 0
  	  header_array = Array.new
  	  results.each do |this_selected_variant|
  	  	  if header_array.empty?
  	  	  	  header_array = this_selected_variant.variable_order
  	  	  	  header_array.map!{ |element| element.to_s }
  	  	  	  vcf_headers = this_selected_variant.print_alleles.map {|var| var[0]}
  	  	  	  header_array = header_array + vcf_headers
  	  	  	  header_array.each do |this_header|
  	  	  	  	  this_sheet.row(row_number).push this_header  
  	  	  	  end
  	  	  end
  	  	  row_number = row_number + 1
  	  	  #output variables to spreadsheet in given order
  	  	  this_selected_variant.variable_order.map {|var|  this_sheet.row(row_number).push  "#{this_selected_variant.send(var)}" }
  	  	  this_selected_variant.print_alleles.map {|var| this_sheet.row(row_number).push "#{var[1]}" }
  	  end
  	  return workbook
  end

  opts = Optimist::options do
  	opt :variants, "Filepath to Alamut file to parse.", :type => String
  	opt :fake_exome_depth, "Filepath to fake Exome Depth file to parse.", :type => String
  	opt :genes, "Filepath to text file with list of valid HGVS gene symbols - one symbol per line.", :type => String
  	opt :ontology_genes, "Filepath to CSV export from HPO web browser.", :type => String
  	opt :approved_genes, "Check gene symbols against HGNC - only process those which are the current symbol"
  	opt :excel_output, "Export results to an Excel spreadsheet."
  	opt :proband_sample, "Proband sample ID to include in output", :type => String
  	opt :clinvar, "Include ClinVar pathogenic candidates (CliniVarClinSignifs: Pathogenic; ClinVarReviewStatus: 3 or 4; ClinVarOrigins: Germline)."
  	opt :research, "Select variants on research criteria.", :default => false
  	opt :maf_cutoff, "Set a Minor Allele Frequency (MAF) cutoff - integer out of 1 based on gnomad all populations frequencies.", :default => 0.01
  	opt :result_prefix, "Set the prefix for the result file output, for example Family ID. Defaults to the directory name two levels up from the Alamut variant file."
  	opt :all, "Parse all variants without a genelist", :default => false
  end
  
  #Optimist::die :alamut_file, "Alamut file must exist." unless File.exist?(opts[:alamut_file]) if opts[:alamut_file]

  variants_filepath = opts[:variants]
  cnvs_filepath = opts[:fake_exome_depth]
  genes_filepath = opts[:genes]
  hpo_genes_filepath = opts[:hpo_genes]
  excel_output = opts[:excel_output]
  proband_sample_id = opts[:proband_sample]
  select_clinvar = opts[:clinvar]
  parse_all = opts[:all]
  research = opts[:research]
  maf_cutoff = opts[:maf_cutoff]
  result_prefix = opts[:result_prefix]
  
  
  if proband_sample_id
  	proband_sample_id = proband_sample_id.downcase
  end
  
  if variants_filepath && (genes_filepath || hpo_genes_filepath || parse_all)

  	options_message = "Analysing variants: #{variants_filepath}\n"
  	options_message += "Variant file found: #{File.file?(variants_filepath)}\n"
  	if genes_filepath
  		options_message += "Gene list file: #{genes_filepath}\n"
  		options_message += "Gene list file found: #{File.file?(genes_filepath)}\n"
  	elsif hpo_genes_filepath
  		options_message += "HPO Gene list file: #{hpo_genes_filepath}\n"
  		options_message += "HPO Gene list file found: #{File.file?(hpo_genes_filepath)}\n"
  	elsif parse_all
  		options_message += "Parsing all variants (no gene list provided)\n"
  	end
  	if research
  		options_message += "Running in research mode\n"
  	end
  	if proband_sample_id
  		options_message += "Proband sample selected: #{proband_sample_id}\n"
  	end
  	options_message += "MAF cutoff set at: #{maf_cutoff}\n"
  	
  	puts options_message
  	
  	gene_symbol_list = []
  	gene_id_list = []
  	parser = VariantParser.new()
  	gene_list_filename = ""
  	
  	if hpo_genes_filepath
  		gene_id_list = parser.parse_hpo_gene_list(hpo_genes_filepath)
  		gene_list_filename = File.basename("#{hpo_genes_filepath}", ".*")
  	elsif genes_filepath
  		gene_symbol_list = parser.parse_gene_list(genes_filepath)
  		gene_list_filename = File.basename("#{genes_filepath}", ".*")
  	end
  	
  	if opts[:check_genes]
  		checked_symbols = Array.new
  		this_symbol_checker = SymbolChecker.new	
  		checked_gene_symbol_list = this_symbol_checker.check_gene_symbols(gene_symbol_list)
  		gene_symbol_list = checked_gene_symbol[0]
  	end
  	
  	sample_ids = parser.parse_sample_ids(variants_filepath)
  	variants = parser.parse_alamut_file(variants_filepath, sample_ids)
  	
  	if cnvs_filepath && gene_symbol_list
  		cnv_sample_ids = parser.parse_sample_ids(cnvs_filepath)
  		cnvs = parser.parse_cnv_file(cnvs_filepath, sample_ids)
  		cnv_store = CnvStore.new(cnvs)
  		cnv_results = cnv_store.select_cnvs(gene_symbol_list, proband_sample_id)
  		puts cnv_results.inspect
  	elsif cnvs_filepath
  		puts "CNV analysis requires gene symbol list."
  	end
  	
  	variant_store = VariantStore.new(variants)
  	
  	results = variant_store.select_variants(gene_symbol_list, gene_id_list, proband_sample_id, parse_all, select_clinvar, maf_cutoff, research)
  	
  	selected_variants = Array.new
  	
  	results[0].each do |variant| 
  		selected_variants.push(variant)
  	end
  	
  	collapsed_selected_results = variant_store.collapse_variants(selected_variants)

  	if !result_prefix && File.file?(variants_filepath)
  		result_prefix = File.expand_path("#{variants_filepath}").split("r01_alamut").first.split('/').last.split('_').first  
  	end
  	
  	if excel_output
  		this_book = Spreadsheet::Workbook.new
  		this_book = parser.variants_to_excel(collapsed_selected_results, this_book)
  		this_book.write "#{result_prefix}_#{Time.now.strftime("%Y-%m-%d-%H%M%S")}_#{gene_list_filename}_virtual-panel_#{ENV['USER']}.xls"
  	else
  		puts "#{results.length} variants selected"
  		puts "#{results.inspect}"
  	end

  else
  	 puts "Check variants file and gene symbols file, try --help for further help."
  end
end
