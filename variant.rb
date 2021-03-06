class Variant

	  attr_accessor :uid, :id, :unannotated_reason, :gene_id, :gene, :gene_description, :chromosome, :position, :gene_symbol, :proband_genotype, :full_transcript, :transcript, :strand
	  attr_accessor :go_bio_process, :go_cell_comp, :go_mol_func
		attr_accessor :transcript_length, :protein, :uniprot, :var_type, :coding_effect, :var_location
		attr_accessor :assembly, :genomic_dna_start, :genomic_dna_end, :genomic_nomen
		attr_accessor :complementary_dna_start, :complementary_dna_end, :cdna_nomen
		attr_accessor :protein, :uniprot, :protein_nomen, :alt_protein_nomen, :exon, :intron, :omim_id
		attr_accessor :distance_nearest_splice_site, :nearest_splice_site_type
		attr_accessor :wt_ssf_score, :wt_max_ent_score, :wt_nns_score, :wt_gs_score, :wt_hsf_score, :var_ssf_score, :var_max_ent_score
		attr_accessor :var_nns_score, :var_gs_score, :var_hsf_score, :nearest_splice_site_change, :local_splice_effect
		attr_accessor :local_ss_pos, :local_ss_wt_nns_score, :local_ss_wt_hsf_score, :local_ss_var_max_ent_score, :local_ss_wt_max_ent_score, :local_ss_var_nns_score, :local_ss_var_hsf_score 
		attr_accessor :branch_point_pos, :branch_point_change
		attr_accessor :protein_domain_1, :protein_domain_2, :protein_domain_3, :protein_domain_4
		attr_accessor :rs_id, :rs_validated, :rs_suspect, :rs_validations, :rs_validation_number, :rs_ancestral_allele
		attr_accessor :rs_heterozygosity, :rs_clinical_significance, :rs_maf, :rs_maf_allele, :rs_maf_count, :highest_maf
		attr_accessor :genomes_1000_freq, :genomes_1000_afr_freq, :genomes_1000_sas_freq, :genomes_1000_eas_freq, :genomes_1000_eur_freq, :genomes_1000_amr_freq
		attr_accessor :gnomad_all_freq, :gnomad_afr_freq, :gnomad_amr_freq, :gnomad_eas_freq, :gnomad_sas_freq, :gnomad_nfe_freq, :gnomad_fin_freq, :gnomad_oth_freq
		attr_accessor :gnomad_afr_hmz,:gnomad_amr_hmz, :gnomad_eas_hmz, :gnomad_sas_hmz, :gnomad_nfe_hmz, :gnomad_fin_hmz, :gnomad_oth_hmz,:gnomad_filter, :gnomad_read_depth
		attr_accessor :gnomad_het_count, :gnomad_hom_count, :gnomad_hem_count
		attr_accessor :esp_ref_ea_count, :esp_ref_aa_count, :esp_ref_all_count, :esp_alt_ea_count, :esp_alt_aa_count
		attr_accessor :esp_alt_all_count, :esp_ea_maf, :esp_aa_maf, :esp_all_maf, :esp_ea_aaf, :esp_aa_aaf, :esp_all_aaf, :esp_avg_read_depth                                                                               
		attr_accessor :hgmd_id, :hgmd_phenotype, :hgmd_pub_med_id, :hgmd_sub_category                                                                                                                                      
		attr_accessor :clin_var_ids, :clin_var_origins, :clin_var_methods, :clin_var_clin_signifs, :clin_var_review_status, :clin_var_phenotypes
		attr_accessor :cosmic_ids, :cosmic_tissues, :cosmic_freqs, :cosmic_sample_counts
		attr_accessor :subst_type, :ins_nucs, :del_nucs, :subst_type, :wt_nuc, :var_nuc, :nuc_change, :phast_cons, :phylo_p
		attr_accessor :wt_aa_1, :wt_aa_3, :wt_codon, :wt_codon_freq, :var_aa_1, :var_aa_3, :var_codon, :var_codon_freq
		attr_accessor :pos_aa, :n_orthos, :conserved_orthos, :conserved_dist_species
		attr_accessor :blosum_45, :blosum_62, :blosum_80, :wt_aa_composition, :var_aa_composition, :wt_aa_polarity
		attr_accessor :var_aa_polarity, :wt_aa_volume, :var_aa_volume, :grantham_dist, :agv_gd_class, :agv_gd_gv, :agv_gd_gd
		attr_accessor :sift_prediction, :sift_weight, :sift_median, :mapp_prediction, :mapp_p_value, :mapp_p_value_median
		attr_accessor :quality_vcf, :filter_vcf
		attr_accessor :ac, :af, :an, :dp, :fs, :mq, :mq_0, :qd
		attr_accessor :ad, :dp, :gq, :gt, :pl
		attr_accessor :alleles, :transcripts
		attr_accessor :reason_for_selection, :reason_for_non_selection, :reason_for_filtering, :collapsed

		def initialize
			self.alleles = Hash.new
		end

		def variable_order						
				variable_order = [:reason_for_selection, :gene, :var_type, :coding_effect, :proband_genotype, :genomic_nomen, :cdna_nomen, :gnomad_het_count, :gnomad_hom_count, :gnomad_hem_count]
				variable_order = variable_order + [:gnomad_all_freq, :highest_maf,  :transcripts, :assembly, :position, :genomic_dna_start, :genomic_dna_end, :var_location, :complementary_dna_start, :complementary_dna_end]
				variable_order = variable_order + [:exon, :intron, :distance_nearest_splice_site, :nearest_splice_site_type, :nearest_splice_site_change]
				variable_order = variable_order + [:transcript_length, :protein, :uniprot]
				variable_order = variable_order + [:protein_nomen, :alt_protein_nomen, :exon, :intron, :omim_id]
				variable_order = variable_order + [:distance_nearest_splice_site, :nearest_splice_site_type]
				variable_order = variable_order + [:wt_ssf_score, :wt_max_ent_score, :wt_nns_score, :wt_gs_score, :wt_hsf_score, :var_ssf_score, :var_max_ent_score]
				variable_order = variable_order + [:var_nns_score, :var_gs_score, :var_hsf_score, :nearest_splice_site_change, :local_splice_effect]
				variable_order = variable_order + [:rs_id, :rs_validated, :rs_suspect, :rs_validations, :rs_validation_number, :rs_ancestral_allele]
				variable_order = variable_order + [:rs_heterozygosity, :rs_clinical_significance, :rs_maf, :rs_maf_allele, :rs_maf_count]
				variable_order = variable_order + [:genomes_1000_freq, :genomes_1000_afr_freq,	:genomes_1000_sas_freq, :genomes_1000_eas_freq, :genomes_1000_eur_freq, :genomes_1000_amr_freq]
				variable_order = variable_order + [:gnomad_all_freq, :gnomad_afr_freq, :gnomad_amr_freq, :gnomad_eas_freq, :gnomad_sas_freq, :gnomad_nfe_freq, :gnomad_fin_freq, :gnomad_oth_freq	]
				variable_order = variable_order + [:gnomad_afr_hmz,:gnomad_amr_hmz, :gnomad_eas_hmz, :gnomad_sas_hmz, :gnomad_nfe_hmz, :gnomad_fin_hmz, :gnomad_oth_hmz,:gnomad_filter, :gnomad_read_depth]
				variable_order = variable_order + [:esp_ref_ea_count, :esp_ref_aa_count, :esp_ref_all_count, :esp_alt_ea_count, :esp_alt_aa_count]
				variable_order = variable_order + [:esp_alt_all_count, :esp_ea_maf, :esp_aa_maf, :esp_all_maf, :esp_ea_aaf,	:esp_aa_aaf, :esp_all_aaf, :esp_avg_read_depth]                                                                             				                        
				variable_order = variable_order + [:hgmd_id, :hgmd_phenotype, :hgmd_pub_med_id, :hgmd_sub_category]
				variable_order = variable_order + [:clin_var_ids,	:clin_var_origins, :clin_var_methods, :clin_var_clin_signifs, :clin_var_review_status, :clin_var_phenotypes]
				variable_order = variable_order + [:ins_nucs, :del_nucs, :subst_type, :wt_nuc, :var_nuc, :nuc_change, :phast_cons, :phylo_p]
				variable_order = variable_order + [:wt_aa_1, :wt_aa_3, :wt_codon, :wt_codon_freq, :var_aa_1, :var_aa_3, :var_codon, :var_codon_freq]
				variable_order = variable_order + [:pos_aa, :n_orthos, :conserved_orthos, :conserved_dist_species]
				variable_order = variable_order + [:blosum_45, :blosum_62, :blosum_80, :wt_aa_composition, :var_aa_composition, :wt_aa_polarity]
				variable_order = variable_order + [:var_aa_polarity, :wt_aa_volume, :var_aa_volume, :grantham_dist, :agv_gd_class, :agv_gd_gv, :agv_gd_gd]
				variable_order = variable_order + [:sift_prediction, :sift_weight, :sift_median, :mapp_prediction, :mapp_p_value, :mapp_p_value_median]
				variable_order = variable_order + [:quality_vcf, :filter_vcf]
				variable_order = variable_order + [:ac, :af, :an, :dp, :fs, :mq, :mq_0, :qd]
				#variable_order = variable_order + [:ad, :dp, :gq, :gt, :pl]
			
			return variable_order
		end
		

		def print_alleles
				allele_hash = Hash.new

				self.alleles.each_pair do |this_sample_id, this_allele|
					     
					allele_hash.store("#{this_sample_id}_ad", this_allele.ad )
					allele_hash.store("#{this_sample_id}_dp", this_allele.dp )
					allele_hash.store("#{this_sample_id}_gq", this_allele.gq )
					allele_hash.store("#{this_sample_id}_gt", this_allele.gt )
					allele_hash.store("#{this_sample_id}_pl", this_allele.pl )

				end
				return allele_hash
		end
		
		def check_genotype(query_sample_id)
			genotype_check = false
			self.alleles.each_pair do |this_sample_id, this_allele|

				if query_sample_id.downcase == this_sample_id.downcase
					
					if (this_allele.gt.eql? './.') || (this_allele.gt.eql? '0/0')
						genotype_check = false
					else
						self.proband_genotype = this_allele.gt
						genotype_check = true
					end
				end
			end
			return genotype_check
		end

		
		def print_attributes
			attr_array = Array.new
			self.instance_variables.map do |var|
				attr_array.push(self.instance_variable_get(var))
  		end
  			return attr_array
		end
		

		def print_attributes_string
			attr_string = '"'
			self.instance_variables.map.with_index do |var, this_index|
				if this_index < self.instance_variables.length-1
					attr_string << self.instance_variable_get(var).to_s 
					attr_string << '", "'
				else
					attr_string << self.instance_variable_get(var).to_s 
					attr_string << '"'
			  end
  		end
  			return attr_string
		end
		
		def is_unwanted_variant?(unwanted_variant_array)
			unwanted = false
			unwanted_reason = ""
			unwanted_variant_array.each do |unwanted_variant|
				if (self.chromosome == unwanted_variant.chromosome) && (self.position == unwanted_variant.position)
					if (unwanted_variant.wt_nuc && (self.wt_nuc == unwanted_variant.wt_nuc) ) && (unwanted_variant.var_nuc && (self.var_nuc == unwanted_variant.var_nuc) )
						unwanted = true
						unwanted_reason = unwanted_variant.reason_for_filtering
						break
					elsif (self.ins_nucs != nil) && (self.ins_nucs == unwanted_variant.ins_nucs)
						unwanted = true
						unwanted_reason = unwanted_variant.reason_for_filtering
						break
					elsif (self.del_nucs != nil) && (self.del_nucs == unwanted_variant.del_nucs)
						#puts "****** unwanted DEL ******* #{self.del_nucs} : #{unwanted_variant.del_nucs}"
						unwanted = true
						unwanted_reason = unwanted_variant.reason_for_filtering
						break
					else
						unwanted = false
					end
				else
						unwanted = false
				end
			end
			return [unwanted, unwanted_reason]
		end
		
		def is_wanted_region?(wanted_region_array)
			wanted = false
			wanted_region_array.each do |wanted_region|
				if (self.chromosome == wanted_region.chromosome) && ((self.position >= wanted_region.start_position) && (self.position <= wanted_region.stop_position)) 
						wanted = true
				else
						wanted = false
				end
			end
			return wanted
		end
		
		def parse_transcript()
			if self.full_transcript
				if self.transcript = self.full_transcript.split(".").first
					return true
				end
			else
				return false
			end
						
		end
		
		def find_highest_maf()
			
			maf_array = [self.genomes_1000_freq, self.genomes_1000_afr_freq, self.genomes_1000_sas_freq, self.genomes_1000_eas_freq, self.genomes_1000_eur_freq, self.genomes_1000_amr_freq]
			maf_array += [self.rs_maf, self.gnomad_afr_freq, self.gnomad_amr_freq, self.gnomad_eas_freq, self.gnomad_sas_freq, self.gnomad_nfe_freq, self.gnomad_oth_freq, self.gnomad_all_freq]
			maf_array.collect!{|maf| maf.nil? ? 0 : maf }
			self.highest_maf = maf_array.max
			
		end
		
		def check_maf_cutoff(maf_cutoff)
			check_cutoff = false
			if self.gnomad_all_freq.to_f <= maf_cutoff.to_f
				check_cutoff = true
			else
				check_cutoff = false
			end
			return check_cutoff
		end
		
		def merge_variant(other_variant)
			self.instance_variables.each do |this_variable|
				#v.instance_variable_get(:@chromosome)
				if this_variable.instance_variable_get(this_variable) != other_variant.instance_variable_get(this_variable)
					updated_variable = "#{this_variable.instance_variable_get(this_variable)};#{other_variant.instance_variable_get(this_variable)}"
					this_variable.instance_variable_set(this_variable, updated_variable)
				end
			end
		end
		
		def to_hash
    	hash = {}
    	instance_variables.each do |var| 
    		#if var == :@alleles
    			
    		#else
    			hash[var[1..-1].to_sym] = instance_variable_get(var)
    		#end
    	end
    	return hash
  	end

end
