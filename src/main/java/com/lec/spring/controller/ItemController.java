package com.lec.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lec.spring.domain.Item;
import com.lec.spring.repository.ColorRepository;
import com.lec.spring.repository.ContentfileRepository;
import com.lec.spring.repository.ItemRepository;
import com.lec.spring.repository.SizeRepository;
import com.lec.spring.service.ItemService;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemService itemService;
	
	@GetMapping("/detail")
	public String itemDetail(String id, Model model) {
		
		Long lId = Long.parseLong(id);
		
//		Item itemId = itemService.findByItemid(lId);
//		System.out.println("itemId : "+itemId);
		
		model.addAttribute("id", id);
		model.addAttribute("item", itemService.findByisvalidItem(lId));
//		model.addAttribute("contentFileList", itemService.getItemContentfile(itemId));
//		model.addAttribute("sizeList", itemService.getItemSize(itemId));
//		model.addAttribute("colorList", itemService.getItemColor(itemId));
		
		return "item/detail";
	}
	
	@PostMapping("/cartOk")
	public String itemCartOk(Long id, String color, String size, Model model) {
		Item itemId = itemService.findByItemid(id);
		System.out.println("itemId = "+itemId);
		System.out.println("color = "+color);
		System.out.println("size = "+size);
		itemService.registerCart(itemId);
		return "redirect:/item/cart" ;
	}
	
	@GetMapping("/cart")
	public String itemCart(Model model) {
		
		model.addAttribute("cartList", itemService.cartList());
		
		return "item/cart";
	}
	
	
}
