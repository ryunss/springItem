package com.lec.spring.domain.item;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(callSuper = true)
@Entity(name = "db_item")
public class Item {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(nullable = false)
	private String itemname;
	@Column(nullable = false)
	private Boolean itemflag;
	@Column(nullable = false)
	private Double discount;
	@Column(nullable = false)
	private String itemcontent;
	@Column(nullable = false)
	private Double price;
	@Column(nullable = false)
	private Long stock;
	@Column(nullable = false)
	private Long reviewCnt;
	@Column(nullable = false)
	private Double avgstar;
	
	@OneToMany(mappedBy ="item" , cascade = CascadeType.ALL)
    @ToString.Exclude
    @Builder.Default
    private List<Color> colors = new ArrayList<>();
	
	@OneToMany(mappedBy ="item" , cascade = CascadeType.ALL)
    @ToString.Exclude
    @Builder.Default
    private List<Size> sizes = new ArrayList<>();
	
	@OneToMany(mappedBy ="item" , cascade = CascadeType.ALL)
    @ToString.Exclude
    @Builder.Default
    private List<Category> categories = new ArrayList<>();
	
	@OneToMany(mappedBy ="item" , cascade = CascadeType.ALL)
    @ToString.Exclude
    @Builder.Default
    private List<Itemfile> itemfiles = new ArrayList<>();
	
	@OneToMany(mappedBy ="item" , cascade = CascadeType.ALL)
    @ToString.Exclude
    @Builder.Default
    private List<Review> reviews = new ArrayList<>();
	
	@OneToMany(mappedBy ="item" , cascade = CascadeType.ALL)
    @ToString.Exclude
    @Builder.Default
    private List<Cart> carts = new ArrayList<>();
	
	@OneToMany(mappedBy ="item" , cascade = CascadeType.ALL)
    @ToString.Exclude
    @Builder.Default
    private List<Buy> buies = new ArrayList<>();
}