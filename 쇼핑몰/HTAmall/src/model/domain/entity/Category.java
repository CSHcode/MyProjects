package model.domain.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@RequiredArgsConstructor

@Getter
@Setter
@ToString

@Entity
public class Category {
	
	@Id
	@NonNull
	@Column(name = "c_id")
	private String categoryId;

	@NonNull
	@Column(name = "c_name")
	private String categoryName;

	@OneToMany(mappedBy = "category")
	private List<Product> product = new ArrayList<Product>();
}
